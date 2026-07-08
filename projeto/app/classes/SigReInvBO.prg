*==============================================================================
* SIGREINVBO.PRG
* Business Object para Relatorio de Inventario de Estoque (SIGREINV)
* Herda de RelatorioBase
*
* Tabela principal: SigTempR (cursor temporario do legado)
* Relatorio FRX: SigReIv1.frx / SigReIv2.frx / SigReIv3.frx
*
* Filtros:
*   - Empresa (codigo + descricao)
*   - Tipo de inventario (ChkInv1=Proprio / ChkInv2=Proprio em poder 3s / ChkInv3=3s em nosso poder)
*   - Saldo (ChkSaldo1=Positivo / ChkSaldo2=Negativo)
*   - Tipo de valor (UEPS/PEPS/Custo/Custo Medio/Venda)
*   - Moeda de conversao (codigo + descricao) e fator de cambio
*   - Posicao (1=Atual / 2=Retroativa) e data de saldo retroativo
*   - ICMS (1=Sim retira / 2=Nao retira)
*==============================================================================

DEFINE CLASS SigReInvBO AS RelatorioBase

    *-- Filtro: empresa
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Filtro: tipo de inventario (espelha Value dos CheckBoxes - 1=marcado 0=desmarcado)
    this_nChkInv1       = 1
    this_nChkInv2       = 0
    this_nChkInv3       = 0

    *-- Filtro: saldo a considerar (1=marcado 0=desmarcado)
    this_nChkSaldo1     = 1
    this_nChkSaldo2     = 0

    *-- Filtro: tipo de valor de custo (apenas um pode estar marcado)
    *   UEPS=1 / PEPS=2 / Custo=3 / CustoMedio=4 / Venda=5
    this_nChkValor1     = 0
    this_nChkValor2     = 1
    this_nChkValor3     = 0
    this_nChkValor4     = 0
    this_nChkValor5     = 0

    *-- Filtro: moeda de conversao (opcional - prioridade sobre o fator)
    this_cMoeda         = ""
    this_cMoedaDesc     = ""

    *-- Filtro: moeda/fator de cambio manual (Get_MoeFator/Get_ValFator do legado)
    this_cMoeFator      = ""
    this_nValFator      = 0

    *-- Filtro: posicao de estoque (1=Atual / 2=Retroativa)
    this_nOptPosicao    = 1

    *-- Filtro: data do saldo retroativo (habilitado quando OptPosicao=2)
    this_dDataSaldo     = {}

    *-- Filtro: ICMS (1=Sim retira ICMS / 2=Nao retira)
    this_nOptIcms       = 2

    *-- Derivados: calculados em FormParaRelatorio a partir de this_nOptIcms
    this_lImpIcms       = .F.
    this_nAliqIcms      = 0

    *-- Nome do cursor de saida gerado por PrepararDados()
    this_cCursorDados   = "CsTemporario"

    *-- Tipo de relatorio selecionado (C=Custo, M=Medio, V=Venda)
    this_cTipoVal       = ""
    this_cTipoRel       = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de inventario de estoque
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigTempR"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosIniciais - Carrega cursores base necessarios antes do uso do form
    * Equivalente ao Init() original do form (carrega CrSigCdEmp, CrSigCdCot etc.)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosIniciais()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_dDatas
        loc_lSucesso = .F.
        loc_dDatas   = DATE()

        TRY
            *-- Carrega lista de empresas
            loc_cSQL = "SELECT CEmps, Razas, Cidas, RazSocs, Endes, IEs, CGCs, Ativas " + ;
                       "FROM SigCdEmp ORDER BY CEmps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdEmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar empresas (CrSigCdEmp)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdEmp
            INDEX ON CEmps TAG CEmps
            GO TOP

            *-- Carrega aliquota ICMS da empresa logada
            loc_cSQL = "SELECT a.CEmps, a.Estas, b.Estados, b.AICMS " + ;
                       "FROM SigCdEmp a, SigCdUfs b " + ;
                       "WHERE a.CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND a.Estas = b.Estados"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrAliqTemp")
            IF loc_nResult > 0
                SELECT CrAliqTemp
                GO TOP
                IF !EOF()
                    THIS.this_nAliqIcms = CrAliqTemp.AICMS
                ENDIF
                USE IN CrAliqTemp
            ENDIF

            *-- Carrega tabela de moedas
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdMoe", "CrSigCdMoe")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar moedas (CrSigCdMoe)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdMoe
            INDEX ON CMoes TAG CMoes
            GO TOP

            *-- Carrega operacoes para identificar PEPS
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT Dopes, Peps FROM SigOpCdc", "CrSigOpCdc")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar operacoes (CrSigOpCdc)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigOpCdc
            INDEX ON Dopes TAG Dopes
            GO TOP

            *-- Carrega historico de cotacoes de moedas
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "CrSigCdCot")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar cotacoes (CrSigCdCot)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdCot
            INDEX ON cmoes + DTOS(datas) TAG CMoeData
            GO TOP

            *-- Carrega moedas com cotacao (para lookup no form)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, DMoes FROM SigCdMoe WHERE Cotas = 1", "TmpMoe")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar TmpMoe"
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpMoe
            INDEX ON CMoes TAG CMoes
            INDEX ON DMoes TAG DMoes
            GO TOP

            *-- Carrega tipos de inventario de SigCdGcr
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, TipoInvs FROM SigCdGcr", "TmpGccr1")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar tipos de inventario (TmpGccr1)"
                loc_lSucesso = .F.
            ENDIF

            *-- Carrega dados das empresas para cabecalho do relatorio
            loc_cSQL = "SELECT CEmps, RazSocs AS Razas, Endes, Cidas, " + ;
                       "SPACE(15) AS NIRCs, ?loc_dDatas AS DRegs, " + ;
                       "Razas AS Nomes, SPACE(14) AS CRCs, IEs, CGCs, " + ;
                       "SPACE(20) AS NIRES, ?loc_dDatas AS Datas, ?loc_dDatas AS DataNIREs " + ;
                       "FROM SigCdEmp"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSlvEmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar CrSlvEmp"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSlvEmp
            INDEX ON CEmps TAG CEmps
            GO TOP

            *-- Define empresa padrao se nao foi preenchida
            IF EMPTY(THIS.this_cCdEmpresa)
                THIS.this_cCdEmpresa = go_4c_Sistema.cCodEmpresa
                SELECT CrSigCdEmp
                IF SEEK(THIS.this_cCdEmpresa, "CrSigCdEmp", "CEmps")
                    THIS.this_cDsEmpresa = ALLTRIM(CrSigCdEmp.Razas)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao de uma moeda em uma data especifica
    * Busca no cursor CrSigCdCot (carregado por CarregarDadosIniciais)
    * Equivalente a fCarregarCambio() do legado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nTaxa, loc_dData, loc_cMoedaPad
        loc_nTaxa = 0
        loc_dData = IIF(EMPTY(par_dData), DATE(), par_dData)

        IF EMPTY(par_cMoeda) OR !USED("CrSigCdCot")
            RETURN 0
        ENDIF

        loc_cMoedaPad = PADR(ALLTRIM(par_cMoeda), 3)

        TRY
            SELECT CrSigCdCot
            SET ORDER TO CMoeData DESCENDING
            SET NEAR ON
            SEEK loc_cMoedaPad + DTOS(loc_dData)
            SET NEAR OFF
            IF !EOF() AND PADR(ALLTRIM(CrSigCdCot.cmoes), 3) = loc_cMoedaPad
                loc_nTaxa = CrSigCdCot.valos
            ENDIF
            SET ORDER TO CMoeData
        CATCH TO loc_oErro
            SET NEAR OFF
        ENDTRY

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa inventario e monta cursores para o relatorio
    * Equivalente ao metodo 'processamento' do form legado
    * Retorna .T. se processamento concluiu com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cWhere
        LOCAL loc_cCdEmpresa, loc_nImpUEPS, loc_nImpPEPS
        LOCAL loc_nImpCusto, loc_nImpMedio, loc_nImpVenda
        LOCAL loc_nValFat, loc_cMoe, loc_lcCampo
        LOCAL loc_llProcEst, loc_llFirst, loc_nTotalGeral

        loc_lSucesso = .F.

        TRY
            *-- Inicializa variaveis dos filtros
            loc_cCdEmpresa = PADR(THIS.this_cCdEmpresa, 3)
            loc_nImpUEPS   = THIS.this_nChkValor1
            loc_nImpPEPS   = THIS.this_nChkValor2
            loc_nImpCusto  = THIS.this_nChkValor3
            loc_nImpMedio  = THIS.this_nChkValor4
            loc_nImpVenda  = THIS.this_nChkValor5
            loc_nValFat    = THIS.this_nValFator
            loc_cMoe       = ALLTRIM(THIS.this_cMoeda)

            *-- Reinicializa TmpGrupo para esta execucao
            IF USED("TmpGrupo")
                USE IN TmpGrupo
            ENDIF
            CREATE CURSOR TmpGrupo (Tipo c(1), CGrus c(80), Moedas c(3), Valors n(12,2))
            INDEX ON Tipo + CGrus + Moedas TAG TpGruMoe

            *-- Define tipo de valor para cabecalho do relatorio
            DO CASE
                CASE loc_nImpCusto = 1
                    THIS.this_cTipoVal = "C"
                    THIS.this_cTipoRel = "Custo"
                CASE loc_nImpMedio = 1
                    THIS.this_cTipoVal = "M"
                    THIS.this_cTipoRel = "Custo M" + CHR(233) + "dio"
                CASE loc_nImpVenda = 1 OR loc_nImpPEPS = 1 OR loc_nImpUEPS = 1
                    THIS.this_cTipoVal = "V"
                    DO CASE
                        CASE loc_nImpVenda = 1
                            THIS.this_cTipoRel = "Venda"
                        CASE loc_nImpPEPS = 1
                            THIS.this_cTipoRel = "PEPS"
                        CASE loc_nImpUEPS = 1
                            THIS.this_cTipoRel = "UEPS"
                    ENDCASE
            ENDCASE

            *-- Carrega grandes grupos
            WAIT WINDOW "Aguarde! Selecionando Grandes Grupos..." NOWAIT
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT Codigos, Descs FROM SigCdGpr", "CrSigCdGpr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar CrSigCdGpr"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdGpr
            INDEX ON Codigos TAG Codigos
            GO TOP

            *-- Carrega grupos
            WAIT WINDOW "Aguarde! Selecionando Grupos..." NOWAIT
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CGrus, Mercs, TipoEstos, Invents FROM SigCdGrp", "CrSigCdGrp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar CrSigCdGrp"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdGrp
            INDEX ON CGrus TAG CGrus
            GO TOP

            *-- Carrega sub-grupos
            WAIT WINDOW "Aguarde! Selecionando Sub-Grupos..." NOWAIT
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CGrus, Codigos, Descricaos, CGrus + Codigos AS GruCods FROM SigCdPsg", ;
                "CrSigCdPsg")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar CrSigCdPsg"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdPsg
            INDEX ON GruCods TAG GruCod
            GO TOP

            *-- Carrega linhas de produto
            WAIT WINDOW "Aguarde! Selecionando Linhas..." NOWAIT
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Linhas, TpCustos, TpVendas FROM SigCdLin", "CrSigCdLin")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar CrSigCdLin"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdLin
            INDEX ON Linhas TAG Linhas
            GO TOP

            *-- Carrega grupos filtrados pelo tipo de inventario selecionado
            loc_cWhere = "0 = 0 AND (" + ;
                IIF(THIS.this_nChkInv1 = 1, "a.TipoInvs = 1 OR ", "") + ;
                IIF(THIS.this_nChkInv2 = 1, "a.TipoInvs = 2 OR ", "") + ;
                IIF(THIS.this_nChkInv3 = 1, "a.TipoInvs = 3 OR ", "")
            loc_cWhere = STUFF(loc_cWhere, LEN(ALLTRIM(loc_cWhere)) - 2, 3, ")")

            loc_cSQL = "SELECT a.Codigos FROM SigCdGcr a, SigCdCli b " + ;
                       "WHERE " + loc_cWhere + " AND a.Codigos = b.Grupos " + ;
                       "GROUP BY a.Codigos ORDER BY a.Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpGccr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar TmpGccr"
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpGccr
            INDEX ON Codigos TAG Codigos
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Nenhum Grupo/Conta Cadastrado com o Tipo de Invent" + ;
                                          CHR(225) + "rio Selecionado"
                loc_lSucesso = .F.
            ENDIF

            *-- Processa empresas (todas ou a especificada)
            IF EMPTY(loc_cCdEmpresa)
                *-- Todas as empresas ativas
                loc_llFirst = .T.
                SELECT CrSigCdEmp
                GO TOP
                SCAN
                    IF CrSigCdEmp.Ativas = 1
                        loc_llProcEst = THIS.ProcEst(ALLTRIM(CrSigCdEmp.CEmps), 0, loc_cMoe)
                        IF !loc_llProcEst
                            loc_lSucesso = .F.
                        ENDIF
                        IF loc_llFirst
                            SELECT * FROM CsTempo INTO CURSOR CsTemporario READWRITE
                            loc_llFirst = .F.
                        ELSE
                            SELECT CsTempo
                            GO TOP
                            SCAN
                                SCATTER MEMO MEMVAR
                                INSERT INTO CsTemporario FROM MEMVAR
                                SELECT CsTempo
                            ENDSCAN
                        ENDIF
                    ENDIF
                ENDSCAN
            ELSE
                *-- Empresa especifica
                loc_llProcEst = THIS.ProcEst(loc_cCdEmpresa, loc_nValFat, loc_cMoe)
                IF !loc_llProcEst
                    loc_lSucesso = .F.
                ENDIF
                WAIT WINDOW "Aguarde! Verificando Produtos..." NOWAIT
                SELECT * FROM CsTempo INTO CURSOR CsTemporario READWRITE
            ENDIF

            *-- Define campo de totalizacao conforme tipo de valor
            DO CASE
                CASE loc_nImpCusto = 1
                    loc_lcCampo = "TotCusto"
                CASE loc_nImpVenda = 1 OR loc_nImpPEPS = 1 OR loc_nImpUEPS = 1
                    loc_lcCampo = "TotVenda"
                CASE loc_nImpMedio = 1
                    loc_lcCampo = "TotMedio"
                OTHERWISE
                    loc_lcCampo = "0"
            ENDCASE

            WAIT WINDOW "Aguarde! Agrupando Grandes Grupos..." NOWAIT

            *-- Calcula totais por grande grupo com conversao de moeda
            IF EMPTY(loc_cMoe)
                SELECT GGrupo, SUM(&loc_lcCampo * Indice) AS Total ;
                  FROM CsTemporario ;
                 WHERE Ps2 = 1 AND Ps = 1 ;
                 GROUP BY 1 ORDER BY 1 ;
                  INTO CURSOR TmpGGrupo READWRITE
            ELSE
                SELECT GGrupo, SUM(&loc_lcCampo * cotacao) AS Total ;
                  FROM CsTemporario ;
                 WHERE Ps2 = 1 AND Ps = 1 ;
                 GROUP BY 1 ORDER BY 1 ;
                  INTO CURSOR TmpGGrupo READWRITE
            ENDIF

            *-- Insere linhas de subtotal por grande grupo e total geral
            loc_nTotalGeral = 0
            SELECT TmpGGrupo
            SCAN
                IF TmpGGrupo.Total <> 0 AND !EMPTY(TmpGGrupo.GGrupo)
                    INSERT INTO CsTemporario (Ps, Ps2, CPros, TotCusto, GGrupo, DPros) ;
                                      VALUES (9, 9, CHR(255), TmpGGrupo.Total, CHR(255), ;
                                              "TOTAL DE " + ALLTRIM(TmpGGrupo.GGrupo) + " :")
                    loc_nTotalGeral = loc_nTotalGeral + TmpGGrupo.Total
                ENDIF
            ENDSCAN
            INSERT INTO CsTemporario (Ps, Ps2, CPros, TotCusto, GGrupo, DPros) ;
                              VALUES (9, 9, CHR(255), loc_nTotalGeral, CHR(255), "TOTAL GERAL :")

            SELECT CsTemporario
            INDEX ON GGrupo + STR(Ps, 1) + CPros + Emps + Grupos + Estos + STR(Ps2, 1) TAG Imprimir2
            GO TOP

            WAIT CLEAR

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcEst - Motor de calculo de inventario de estoque por empresa
    * Equivalente ao metodo 'procest' do form legado
    * par_cFilEmp  = codigo da empresa
    * par_nValCot  = fator de cambio manual (0 = nao usar)
    * par_cMoeda   = moeda de conversao (vazia = sem conversao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcEst(par_cFilEmp, par_nValCot, par_cMoeda)
        LOCAL loc_lSucesso
        LOCAL loc_nPosicao, loc_nSldPos, loc_nSldNeg, loc_llImpICMS
        LOCAL loc_dDtAtu, loc_tDatas, loc_dDataRef
        LOCAL loc_nImpUEPS, loc_nImpPEPS, loc_nImpCusto, loc_nImpMedio, loc_nImpVenda
        LOCAL loc_nCota, loc_nValCot
        LOCAL loc_cFiltro, loc_cSQL, loc_nResult
        LOCAL loc_lcChave, loc_llPular
        LOCAL loc_cIdQuery, loc_nFalta
        LOCAL loc_lnQtds, loc_lnTQtds, loc_cDPros
        LOCAL loc_cEmg, loc_nIcmsAliq
        LOCAL m_SQtds, m_VlMedio, m_MoeMedio, m_TipEsts
        LOCAL m_VlCusto, m_MoeCusto, m_VlVenda, m_MoeVenda
        LOCAL m_TotCusto, m_TotVenda, m_TotMedio, m_TotSQtds
        LOCAL m_ValIcms, m_Indice, m_cotacao

        loc_lSucesso = .F.
        loc_dDtAtu   = DATE()

        *-- Inicializa variaveis dos filtros a partir das propriedades do BO
        loc_nPosicao  = THIS.this_nOptPosicao
        loc_nSldPos   = THIS.this_nChkSaldo1
        loc_nSldNeg   = THIS.this_nChkSaldo2
        loc_llImpICMS = (THIS.this_nOptIcms = 1)
        loc_nImpUEPS  = THIS.this_nChkValor1
        loc_nImpPEPS  = THIS.this_nChkValor2
        loc_nImpCusto = THIS.this_nChkValor3
        loc_nImpMedio = THIS.this_nChkValor4
        loc_nImpVenda = THIS.this_nChkValor5
        loc_nValCot   = par_nValCot
        loc_nIcmsAliq = THIS.this_nAliqIcms

        *-- Define data de referencia (com hora 23:59:59)
        IF loc_nPosicao = 1
            loc_tDatas  = CTOT(DTOC(DATE()) + " 23:59:59")
            loc_dDataRef = DATE()
        ELSE
            IF EMPTY(THIS.this_dDataSaldo)
                loc_tDatas  = CTOT(DTOC(DATE()) + " 23:59:59")
                loc_dDataRef = DATE()
            ELSE
                loc_tDatas  = CTOT(DTOC(THIS.this_dDataSaldo) + " 23:59:59")
                loc_dDataRef = THIS.this_dDataSaldo
            ENDIF
        ENDIF

        *-- Calrega cotacao da moeda de conversao (se especificada)
        loc_nCota = 0
        IF !EMPTY(par_cMoeda)
            loc_nCota = THIS.CarregarCambio(par_cMoeda, loc_dDataRef)
        ENDIF

        *-- Ajusta cotacao manual (se nao informado, carrega cambio do proprio fator)
        IF loc_nValCot = 0 AND !EMPTY(par_cFilEmp)
            loc_nValCot = THIS.CarregarCambio(par_cFilEmp, loc_dDataRef)
        ENDIF

        TRY
            *-- Zera TmpGrupo para esta empresa
            ZAP IN TmpGrupo

            *-- Cria cursores de trabalho
            IF USED("csTempo")
                USE IN csTempo
            ENDIF
            IF USED("csInventario")
                USE IN csInventario
            ENDIF

            CREATE CURSOR csTempo (CGrus c(80), DPros c(55), CUnis c(3), Reffs c(40), ;
                CPros c(14), CodCors c(4), CodTams c(4), VlCusto n(12,2), MoeCusto c(3), ;
                VlVenda n(12,2), MoeVenda c(3), VlMedio n(14,4), MoeMedio c(3), ;
                Emps c(3), Grupos c(10), Estos c(10), SQtds n(12,3), TEQtds n(10,3), ;
                TipEsts c(15), TSQtds n(10,3), TotSQtds n(16,3), TotCusto n(20,2), ;
                TotVenda n(20,2), TotMedio n(20,2), lCPros l(1), Ps n(1), Ps2 n(1), ;
                MoeTotal c(3), ClFiscals c(10), GGrupo c(40), PesoMs n(12,2), ;
                Respos c(10), DRespos c(30), Indice n(12,6), ValIcms n(14,4), ;
                TipoInvs n(1), cotacao n(12,6))
            INDEX ON Emps + Grupos + Estos + CPros TAG EmpGrEsCp
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG chvCorTam

            CREATE CURSOR csInventario (CGrus c(80), DPros c(55), CUnis c(3), Reffs c(40), ;
                CPros c(14), CodCors c(4), CodTams c(4), VlCusto n(12,2), MoeCusto c(3), ;
                VlVenda n(12,2), MoeVenda c(3), VlMedio n(14,4), MoeMedio c(3), ;
                Emps c(3), Grupos c(10), Estos c(10), SQtds n(12,3), TEQtds n(10,3), ;
                TipEsts c(15), TSQtds n(10,3), TotSQtds n(16,3), TotCusto n(20,2), ;
                TotVenda n(20,2), TotMedio n(20,2), lCPros l(1), Ps n(1), Ps2 n(1), ;
                MoeTotal c(3), ClFiscals c(10), GGrupo c(40), PesoMs n(12,2), ;
                Respos c(10), DRespos c(30), Indice n(12,6), ValIcms n(14,4), ;
                TipoInvs n(1), cotacao n(12,6))

            *-- Monta lista de grupos para filtro
            loc_cFiltro = ""
            SELECT TmpGccr
            SCAN
                loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro), "'", ",'") + ;
                              PADR(TmpGccr.Codigos, 10) + "'"
            ENDSCAN

            *-- Carrega estoque atual do SQL Server
            WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.CPros, a.CodCors, a.CodTams, " + ;
                       "a.SQtds, a.TEQtds, a.TSQtds, a.TipEsts, a.UnitMeds, a.MoedMeds, " + ;
                       "a.CIdChaves, b.CGrus, b.SGrus, b.Reffs, b.Linhas, b.Situas, " + ;
                       "b.DPros, b.CUnis, b.PesoMs, b.ClFiscals, b.CustoFs, " + ;
                       "b.PVens, b.FVendas, b.MoePVs, b.MoeCusFs, b.MoeVs " + ;
                       "FROM SigMvEst a INNER JOIN SigCdPro b ON b.CPros = a.CPros " + ;
                       "WHERE a.Emps = " + EscaparSQL(par_cFilEmp) + ;
                       " AND a.Grupos IN(" + loc_cFiltro + ") " + ;
                       "ORDER BY a.CIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEst1")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (TmpEst1)"
                loc_lSucesso = .F.
            ENDIF

            *-- Junta TmpEst1 com TmpGccr1 para obter TipoInvs
            SELECT a.Emps, a.Grupos, a.Estos, a.CPros, a.CodCors, a.CodTams, ;
                   a.SQtds, a.TEQtds, a.TSQtds, a.TipEsts, a.UnitMeds, a.MoedMeds, ;
                   a.CIdChaves, a.CGrus, a.SGrus, a.Reffs, a.Linhas, a.Situas, ;
                   a.DPros, a.CUnis, a.PesoMs, a.ClFiscals, a.CustoFs, ;
                   a.PVens, a.FVendas, a.MoePVs, a.MoeCusFs, a.MoeVs, b.TipoInvs ;
              FROM TmpEst1 a, TmpGccr1 b ;
             WHERE a.Grupos = b.Codigos ;
              INTO CURSOR TmpEst READWRITE

            SELECT TmpEst
            INDEX ON Emps + Grupos + Estos + CPros TAG EGEPs
            INDEX ON Emps + Grupos + Estos + CPros + CodCors TAG EGEPCs
            INDEX ON Emps + Grupos + Estos + CPros + CodTams TAG EGEPTs
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG EGEPCTs

            *-- Processamento retroativo: calcula saldos na data especificada
            IF loc_nPosicao = 2
                UPDATE TmpEst SET SQtds = 0, TEQtds = 0, TSQtds = 0
                SELECT TmpEst
                GO TOP
                IF !EOF()
                    *-- Cria cursor de combinacoes empresa+grupo+estoque
                    SELECT DISTINCT Emps + Grupos + Estos AS EmpGruEsts ;
                      FROM TmpEst ;
                     ORDER BY 1 ;
                      INTO CURSOR CsEst READWRITE

                    *-- Gera chave unica para este lote
                    loc_cIdQuery = SYS(2015) + SYS(2015)

                    *-- Insere chaves no SigTempR para uso na query de historico
                    SELECT CsEst
                    SCAN
                        loc_cSQL = "INSERT INTO SigTempR (cIdChaves, cIdQuerys, EmpGruEsts) " + ;
                                   "VALUES ('" + SYS(2015) + "', " + ;
                                   EscaparSQL(loc_cIdQuery) + ", " + ;
                                   EscaparSQL(CsEst.EmpGruEsts) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Falha ao inserir em SigTempR"
                            *-- Tenta limpar registros parcialmente inseridos
                            SQLEXEC(gnConnHandle, ;
                                "DELETE FROM SigTempR WHERE cIdQuerys = " + EscaparSQL(loc_cIdQuery))
                            loc_lSucesso = .F.
                        ENDIF
                    ENDSCAN

                    *-- Carrega movimentacoes historicas ate a data de referencia
                    WAIT WINDOW "Aguarde! Selecionando Movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT

                    IF loc_nImpPEPS = 1
                        loc_cSQL = "SELECT a.EmpGruEsts, a.OriDopNums, a.Emps, a.Grupos, " + ;
                                   "a.Estos, a.CPros, a.Datas, a.Qtds, " + ;
                                   "a.Opers, a.SQtds, a.TEQtds, a.TSQtds, a.Units, " + ;
                                   "a.Pesos, a.cIdChaves, a.Dopes, o.Peps, a.CodCors, a.CodTams " + ;
                                   "FROM SigOpCdc o " + ;
                                   "INNER JOIN SigMvHst a ON o.Dopes = a.Dopes " + ;
                                   "INNER JOIN SigTempR b ON b.EmpGruEsts = a.EmpGruEsts " + ;
                                   "WHERE b.cIdQuerys = " + EscaparSQL(loc_cIdQuery) + ;
                                   " AND a.Datas <= ?loc_tDatas " + ;
                                   "ORDER BY a.EmpGruEsts, a.CPros, a.cIdChaves"
                    ELSE
                        loc_cSQL = "SELECT a.EmpGruEsts, a.OriDopNums, a.Emps, a.Grupos, " + ;
                                   "a.Estos, a.CPros, a.Datas, a.Qtds, " + ;
                                   "a.Opers, a.SQtds, a.TEQtds, a.TSQtds, a.Units, " + ;
                                   "a.Pesos, a.cIdChaves, a.Dopes, 0 AS Peps, a.CodCors, a.CodTams " + ;
                                   "FROM SigMvHst a " + ;
                                   "INNER JOIN SigTempR b ON b.EmpGruEsts = a.EmpGruEsts " + ;
                                   "WHERE b.cIdQuerys = " + EscaparSQL(loc_cIdQuery) + ;
                                   " AND a.Datas <= ?loc_tDatas " + ;
                                   "ORDER BY a.EmpGruEsts, a.CPros, a.cIdChaves"
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHis")
                    IF loc_nResult < 0
                        SQLEXEC(gnConnHandle, ;
                            "DELETE FROM SigTempR WHERE cIdQuerys = " + EscaparSQL(loc_cIdQuery))
                        THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (TmpHis - retro)"
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT TmpHis
                    INDEX ON EmpGruEsts + CPros + cIdChaves TAG EmpPro1
                    INDEX ON EmpGruEsts + CPros + CodCors + CodTams + cIdChaves DESCENDING TAG EmpPro2
                    INDEX ON Emps + CPros + cIdChaves DESCENDING TAG EmpPro3

                    WAIT CLEAR

                    *-- Atualiza quantidades em TmpEst com saldos historicos
                    IF !EOF("TmpHis")
                        SELECT TmpEst
                        SCAN
                            LOCAL loc_lcChaveHis
                            loc_lcChaveHis = TmpEst.Emps + TmpEst.Grupos + TmpEst.Estos + ;
                                             TmpEst.CPros + TmpEst.CodCors + TmpEst.CodTams
                            IF SEEK(loc_lcChaveHis, "TmpHis", "EmpPro2")
                                REPLACE SQtds  WITH TmpHis.SQtds, ;
                                        TEQtds WITH TmpHis.TEQtds, ;
                                        TSQtds WITH TmpHis.TSQtds IN TmpEst
                            ENDIF
                        ENDSCAN
                    ENDIF

                    *-- Limpa chaves temporarias do SigTempR
                    SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigTempR WHERE cIdQuerys = " + EscaparSQL(loc_cIdQuery))
                ENDIF
            ENDIF

            *-- Monta cursor crSigMvEst1 juntando TmpEst + grupos + grandes grupos
            WAIT WINDOW "Aguarde! Verificando Produtos..." NOWAIT
            SELECT a.Emps, a.Grupos, a.Estos, a.CPros, ;
                   IIF(INLIST(b.TipoEstos, 2, 4), a.CodCors, SPACE(LEN(a.CodCors))) AS CodCors, ;
                   IIF(INLIST(b.TipoEstos, 3, 4), a.CodTams, SPACE(LEN(a.CodTams))) AS CodTams, ;
                   a.TipEsts, a.UnitMeds, a.MoedMeds, ;
                   a.CGrus, a.SGrus, a.Reffs, a.Linhas, a.Situas, a.DPros, a.CUnis, ;
                   a.PesoMs, a.ClFiscals, a.CustoFs, a.PVens, a.FVendas, a.MoePVs, ;
                   a.MoeCusFs, a.MoeVs, a.TipoInvs, ;
                   IIF(INLIST(b.TipoEstos, 2, 3, 4), b.TipoEstos, 1) AS TipoEstos, ;
                   b.Mercs, a.CGrus + a.SGrus AS GruCods, ;
                   SPACE(6) AS Codigos, SPACE(20) AS Descricaos, ;
                   " " AS TpCustos, " " AS TpVendas, ;
                   a.SQtds, a.TEQtds, a.TSQtds, c.Descs ;
              FROM TmpEst a ;
             INNER JOIN CrSigCdGrp b ON b.CGrus = a.CGrus ;
             INNER JOIN CrSigCdGpr c ON c.Codigos = b.Mercs ;
             WHERE b.Invents = 1 ;
               AND !EMPTY(b.CGrus) ;
               AND !EMPTY(c.Codigos) ;
              INTO CURSOR crSigMvEst1 READWRITE

            *-- Agrega crSigMvEst1 com sub-grupos e linhas
            SELECT a.Emps, a.Grupos, a.Estos, a.CPros, a.CodCors, a.CodTams, ;
                   a.TipEsts, a.UnitMeds, a.MoedMeds, a.CGrus, a.SGrus, ;
                   a.Reffs, a.Linhas, a.Situas, a.DPros, a.CUnis, a.PesoMs, ;
                   a.ClFiscals, a.CustoFs, a.PVens, a.FVendas, a.MoePVs, ;
                   a.MoeCusFs, a.MoeVs, a.TipoInvs, a.Mercs, a.TipoEstos, a.Descs, ;
                   NVL(b.Codigos, SPACE(6)) AS Codigos, ;
                   NVL(b.Descricaos, SPACE(20)) AS Descricaos, ;
                   NVL(c.TpCustos, " ") AS TpCustos, ;
                   NVL(c.TpVendas, " ") AS TpVendas, ;
                   SUM(a.SQtds) AS SQtds, SUM(a.TEQtds) AS TEQtds, SUM(a.TSQtds) AS TSQtds ;
              FROM crSigMvEst1 a ;
              LEFT JOIN CrSigCdPsg b ON b.GruCods = a.GruCods ;
              LEFT JOIN CrSigCdLin c ON c.Linhas = a.Linhas ;
             GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, ;
                      17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 ;
              INTO CURSOR crSigMvEst READWRITE

            SELECT crSigMvEst
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG EstCorTam
            GO TOP

            *-- Carrega historico para PEPS/UEPS em posicao atual (nao retroativa)
            IF (loc_nImpPEPS = 1 OR loc_nImpUEPS = 1) AND loc_nPosicao = 1
                WAIT WINDOW "Aguarde! Selecionando Movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT

                SELECT DISTINCT Emps FROM TmpEst ORDER BY Emps INTO CURSOR csEst READWRITE

                *-- Monta filtro de empresas
                DO CASE
                    CASE RECCOUNT("csEst") = 1
                        SELECT csEst
                        GO TOP
                        loc_cEmg = " = " + EscaparSQL(csEst.Emps)
                    CASE RECCOUNT("csEst") = 0
                        loc_cEmg = " = " + EscaparSQL(par_cFilEmp)
                    OTHERWISE
                        LOCAL loc_cEmpLista
                        loc_cEmpLista = ""
                        SELECT csEst
                        SCAN
                            loc_cEmpLista = loc_cEmpLista + ;
                                IIF(EMPTY(loc_cEmpLista), "", ",") + EscaparSQL(csEst.Emps)
                        ENDSCAN
                        loc_cEmg = " IN (" + loc_cEmpLista + ")"
                ENDCASE

                IF loc_nImpPEPS = 1
                    loc_cSQL = "SELECT a.Datas, a.Emps, a.EmpGruEsts, a.OriDopNums, " + ;
                               "a.Grupos, a.Estos, a.CPros, a.Qtds, a.Opers, " + ;
                               "a.SQtds, a.TEQtds, a.TSQtds, a.Units, a.Pesos, " + ;
                               "a.cIdChaves, a.Dopes, o.Peps " + ;
                               "FROM SigOpCdc o INNER JOIN SigMvHst a ON a.Dopes = o.Dopes " + ;
                               "WHERE o.Peps = 1 " + ;
                               "AND a.Datas <= ?loc_tDatas " + ;
                               "AND a.Emps " + loc_cEmg + " " + ;
                               "ORDER BY a.EmpGruEsts, a.CPros, a.cIdChaves"
                ELSE
                    loc_cSQL = "SELECT EmpGruEsts, OriDopNums, Emps, Grupos, Estos, CPros, " + ;
                               "Datas, Qtds, Opers, SQtds, TEQtds, TSQtds, Units, Pesos, " + ;
                               "cIdChaves, Dopes, 0 AS Peps " + ;
                               "FROM SigMvHst " + ;
                               "WHERE Emps " + loc_cEmg + ;
                               " AND Datas <= ?loc_tDatas " + ;
                               "ORDER BY EmpGruEsts, CPros, cIdChaves"
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHis")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (TmpHis - atual)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT TmpHis
                INDEX ON EmpGruEsts + CPros + cIdChaves TAG EmpPro1
                INDEX ON EmpGruEsts + CPros + cIdChaves DESCENDING TAG EmpPro2
                INDEX ON Emps + CPros + cIdChaves DESCENDING TAG EmpPro3

                WAIT CLEAR
            ENDIF

            *-- Loop principal: calcula valores por produto
            WAIT WINDOW "Aguarde! Totalizando Produtos..." NOWAIT
            loc_nFalta = RECCOUNT("crSigMvEst")

            SELECT crSigMvEst
            GO TOP
            SCAN WHILE !EOF()
                loc_nFalta = loc_nFalta - 1
                WAIT WINDOW "Aguarde! Processando Estoque - Faltam: " + ;
                            TRANSFORM(loc_nFalta) + " registros..." NOWAIT

                SELECT crSigMvEst
                loc_lcChave = Emps + Grupos + Estos + CPros + CodCors + CodTams
                loc_llPular = .F.

                m_VlMedio  = 0
                m_MoeMedio = " "

                IF loc_nPosicao = 2
                    *-- Posicao retroativa: busca quantidades do historico
                    LOCAL loc_cChaveRet
                    loc_cChaveRet = crSigMvEst.Emps + crSigMvEst.Grupos + ;
                                    crSigMvEst.Estos + crSigMvEst.CPros

                    SELECT SUM(SQtds) AS SQtds, UnitMeds, MoedMeds ;
                      FROM TmpEst ;
                     WHERE Emps + Grupos + Estos + CPros = m.loc_cChaveRet ;
                     GROUP BY UnitMeds, MoedMeds ;
                      INTO CURSOR crResulta

                    m_VlMedio  = crResulta.UnitMeds
                    m_MoeMedio = crResulta.MoedMeds
                    m_TipEsts  = " "
                    IF crResulta.SQtds = 0 ;
                        OR (loc_nSldNeg = 1 AND crResulta.SQtds > 0) ;
                        OR (loc_nSldPos = 1 AND crResulta.SQtds < 0)
                        loc_llPular = .T.
                    ENDIF

                    SELECT crSigMvEst
                    SCATTER MEMO MEMVAR
                    m.SQtds = crResulta.SQtds
                ELSE
                    *-- Posicao atual
                    LOCAL loc_nRegEst
                    loc_nRegEst = RECNO("crSigMvEst")
                    SET ORDER TO EstCorTam DESCENDING IN crSigMvEst
                    GO TOP IN crSigMvEst
                    SEEK loc_lcChave IN crSigMvEst
                    m_VlMedio  = crSigMvEst.UnitMeds
                    m_MoeMedio = crSigMvEst.MoedMeds
                    m_TipEsts  = " "
                    IF crSigMvEst.SQtds = 0 ;
                        OR (loc_nSldNeg = 1 AND crSigMvEst.SQtds > 0) ;
                        OR (loc_nSldPos = 1 AND crSigMvEst.SQtds < 0)
                        loc_llPular = .T.
                    ENDIF
                    SET ORDER TO EstCorTam ASCENDING IN crSigMvEst
                    GO TOP IN crSigMvEst
                    GO loc_nRegEst IN crSigMvEst
                    SELECT crSigMvEst
                    SCATTER MEMO MEMVAR
                ENDIF

                IF !loc_llPular
                    m.CGrus   = SPACE(10) + PADR(crSigMvEst.CGrus, 80)
                    m.Respos  = SPACE(10)
                    m.DRespos = SPACE(30)
                    m.VlVenda = ROUND(crSigMvEst.PVens * ;
                                IIF(crSigMvEst.FVendas <> 0 AND !EMPTY(crSigMvEst.MoePVs), ;
                                    crSigMvEst.FVendas, 1), 2)

                    IF !EMPTY(crSigMvEst.Linhas)
                        IF crSigMvEst.TpCustos = "2"
                            m.VlCusto = crSigMvEst.PesoMs * crSigMvEst.CustoFs
                        ENDIF
                        IF crSigMvEst.TpVendas = "2"
                            m.VlVenda = crSigMvEst.PesoMs * m.VlVenda
                        ENDIF
                    ENDIF

                    m.MoeCusto = m.MoeCusFs
                    m.MoeVenda = m.MoeVs
                    m.TotSQtds = m.SQtds
                    m.VlCusto  = m.CustoFs
                    m.VlMedio  = m_VlMedio
                    m.MoeMedio = m_MoeMedio
                    m.TotCusto = ROUND(m.VlCusto * m.SQtds, 2)
                    m.TotVenda = ROUND(m.VlVenda * m.SQtds, 2)
                    m.TotMedio = ROUND(m_VlMedio * m.SQtds, 2)
                    m.lCPros   = .F.
                    m.Ps       = 1
                    m.Indice   = loc_nValCot
                    m.cotacao  = IIF(loc_nCota = 0, 0, ;
                                     THIS.CarregarCambio(m.MoeCusFs, loc_dDataRef) / loc_nCota)
                    m.Ps2      = 1

                    INSERT INTO csTempo FROM MEMVAR

                    *-- Acumula totais em TmpGrupo por tipo de valor
                    IF loc_nImpCusto = 1
                        SELECT TmpGrupo
                        SEEK "1" + csTempo.CGrus + csTempo.MoeCusto IN TmpGrupo
                        IF EOF("TmpGrupo")
                            INSERT INTO TmpGrupo (Tipo, CGrus, Moedas) ;
                                VALUES ("1", csTempo.CGrus, csTempo.MoeCusto)
                        ENDIF
                        REPLACE Valors WITH TmpGrupo.Valors + m.TotCusto IN TmpGrupo
                    ENDIF

                    IF loc_nImpVenda = 1 OR loc_nImpPEPS = 1 OR loc_nImpUEPS = 1
                        SELECT TmpGrupo
                        SEEK "2" + csTempo.CGrus + csTempo.MoeVenda IN TmpGrupo
                        IF EOF("TmpGrupo")
                            INSERT INTO TmpGrupo (Tipo, CGrus, Moedas) ;
                                VALUES ("2", csTempo.CGrus, csTempo.MoeVenda)
                        ENDIF
                        REPLACE Valors WITH TmpGrupo.Valors + m.TotVenda IN TmpGrupo
                    ENDIF

                    IF loc_nImpMedio = 1
                        SELECT TmpGrupo
                        SEEK "3" + csTempo.CGrus + csTempo.MoeMedio IN TmpGrupo
                        IF EOF("TmpGrupo")
                            INSERT INTO TmpGrupo (Tipo, CGrus, Moedas) ;
                                VALUES ("3", csTempo.CGrus, csTempo.MoeMedio)
                        ENDIF
                        REPLACE Valors WITH TmpGrupo.Valors + m.TotMedio IN TmpGrupo
                    ENDIF
                ENDIF

                SELECT crSigMvEst
            ENDSCAN

            *-- Recalcula valores para PEPS e UEPS a partir do historico
            IF loc_nImpPEPS = 1 OR loc_nImpUEPS = 1

                WAIT WINDOW "Aguarde! Recalculando Valores..." NOWAIT

                SELECT CsTempo
                GO TOP
                SCAN
                    SCATTER MEMO MEMVAR
                    loc_cDPros = m.DPros

                    IF USED("TmpHis") AND !EOF("TmpHis")
                        *-- Ordena TmpHis: PEPS = cronologico asc, UEPS = cronologico desc
                        IF loc_nImpPEPS = 1
                            SET ORDER TO EmpPro3 IN TmpHis
                        ELSE
                            SET ORDER TO EmpPro3 IN TmpHis
                        ENDIF

                        SET KEY TO m.Emps + m.CPros IN TmpHis
                        GO TOP IN TmpHis

                        IF loc_nImpPEPS = 1
                            SET NEAR ON
                            SEEK m.Emps + m.CPros + DTOS(loc_dDataRef) IN TmpHis
                            SET NEAR OFF
                        ELSE
                            *-- UEPS: busca da posicao de corte em direcao ao inicio
                            SET NEAR ON
                            SEEK m.Emps + m.CPros + DTOS(loc_dDataRef) IN TmpHis
                            SET NEAR OFF
                        ENDIF

                        loc_lnQtds  = 0
                        loc_lnTQtds = m.SQtds * IIF(loc_nSldNeg = 1, -1, 1)

                        IF loc_lnTQtds > 0
                            DO WHILE !EOF("TmpHis") AND loc_lnTQtds <> 0
                                IF TmpHis.Opers = "E" AND TmpHis.Units > 0 AND TmpHis.Peps = 1
                                    IF loc_lnTQtds < TmpHis.Qtds
                                        REPLACE Qtds WITH TmpHis.Qtds - loc_lnTQtds IN TmpHis
                                        loc_lnQtds  = loc_lnTQtds
                                        loc_lnTQtds = 0
                                    ELSE
                                        loc_lnTQtds = loc_lnTQtds - TmpHis.Qtds
                                        loc_lnQtds  = TmpHis.Qtds
                                        REPLACE Qtds WITH 0 IN TmpHis
                                    ENDIF

                                    m.VlVenda  = TmpHis.Units
                                    m.TotVenda = loc_lnQtds * m.VlVenda
                                    m.DPros    = loc_cDPros
                                    m.SQtds    = loc_lnQtds
                                    m.ValIcms  = 0

                                    IF loc_llImpICMS
                                        loc_cSQL = "SELECT EmpDopNums, CPros, AliqICMS " + ;
                                                   "FROM SigMvItn " + ;
                                                   "WHERE EmpDopNums = " + EscaparSQL(TmpHis.OriDopNums) + ;
                                                   " AND CPros = " + EscaparSQL(TmpHis.CPros) + ;
                                                   " ORDER BY EmpDopNums, CPros, AliqICMS"
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crLclMvItn") > 0
                                            SELECT crLclMvItn
                                            GO TOP
                                            IF !EOF()
                                                m.ValIcms = (m.TotVenda * ;
                                                    IIF(crLclMvItn.AliqIcms = 0, ;
                                                        loc_nIcmsAliq, crLclMvItn.AliqIcms)) / 100
                                            ENDIF
                                            USE IN crLclMvItn
                                        ENDIF
                                    ENDIF

                                    INSERT INTO csInventario FROM MEMVAR
                                ENDIF

                                SELECT TmpHis
                                IF loc_nImpPEPS = 1
                                    SKIP
                                ELSE
                                    SKIP -1
                                ENDIF
                            ENDDO

                            IF loc_lnTQtds <> 0
                                m.SQtds    = loc_lnTQtds
                                m.VlVenda  = 0
                                m.TotVenda = 0
                                m.DPros    = loc_cDPros
                                m.ValIcms  = 0
                                INSERT INTO csInventario FROM MEMVAR
                            ENDIF
                        ELSE
                            m.VlVenda  = 0
                            m.TotVenda = 0
                            m.ValIcms  = 0
                            INSERT INTO csInventario FROM MEMVAR
                        ENDIF

                        SET KEY TO IN TmpHis
                    ELSE
                        m.VlVenda  = 0
                        m.TotVenda = 0
                        m.ValIcms  = 0
                        INSERT INTO csInventario FROM MEMVAR
                    ENDIF

                    SELECT CsTempo
                ENDSCAN

                *-- Agrega csInventario e substitui csTempo
                IF USED("csTempo")
                    ZAP IN csTempo
                ENDIF

                SELECT ClFiscals, CPros, lCPros, Emps, Grupos, Estos, CUnis, VlVenda, ;
                       MAX(CGrus) AS CGrus, MAX(DPros) AS DPros, MAX(Reffs) AS Reffs, ;
                       MAX(CodCors) AS CodCors, MAX(CodTams) AS CodTams, ;
                       MAX(VlCusto) AS VlCusto, MAX(MoeCusto) AS MoeCusto, ;
                       MAX(MoeVenda) AS MoeVenda, MAX(VlMedio) AS VlMedio, ;
                       MAX(MoeMedio) AS MoeMedio, MAX(TEQtds) AS TEQtds, ;
                       MAX(TipEsts) AS TipEsts, MAX(TSQtds) AS TSQtds, ;
                       MAX(TotSQtds) AS TotSQtds, MAX(Ps) AS Ps, MAX(Ps2) AS Ps2, ;
                       MAX(MoeTotal) AS MoeTotal, MAX(GGrupo) AS GGrupo, ;
                       MAX(PesoMs) AS PesoMs, MAX(Respos) AS Respos, ;
                       MAX(DRespos) AS DRespos, MAX(Indice) AS Indice, ;
                       MAX(TipoInvs) AS TipoInvs, ;
                       SUM(SQtds) AS SQtds, SUM(TotCusto) AS TotCusto, ;
                       SUM(TotVenda) AS TotVenda, SUM(TotMedio) AS TotMedio, ;
                       SUM(ValIcms) AS ValIcms, MAX(cotacao) AS cotacao ;
                  FROM csInventario ;
                 GROUP BY ClFiscals, CPros, lCPros, Emps, Grupos, Estos, CUnis, VlVenda ;
                  INTO CURSOR csInvent2

                SELECT csInvent2
                SCAN
                    SCATTER MEMO MEMVAR
                    INSERT INTO csTempo FROM MEMVAR
                    SELECT csInvent2
                ENDSCAN

            ELSE
                *-- Sem PEPS/UEPS: agrega csTempo por produto
                SELECT ClFiscals, CPros, lCPros, Emps, Grupos, Estos, CUnis, VlVenda, ;
                       MAX(CGrus) AS CGrus, MAX(DPros) AS DPros, MAX(Reffs) AS Reffs, ;
                       MAX(CodCors) AS CodCors, MAX(CodTams) AS CodTams, ;
                       MAX(VlCusto) AS VlCusto, MAX(MoeCusto) AS MoeCusto, ;
                       MAX(MoeVenda) AS MoeVenda, MAX(VlMedio) AS VlMedio, ;
                       MAX(MoeMedio) AS MoeMedio, MAX(TEQtds) AS TEQtds, ;
                       MAX(TipEsts) AS TipEsts, MAX(TSQtds) AS TSQtds, ;
                       MAX(TotSQtds) AS TotSQtds, MAX(Ps) AS Ps, MAX(Ps2) AS Ps2, ;
                       MAX(MoeTotal) AS MoeTotal, MAX(GGrupo) AS GGrupo, ;
                       MAX(PesoMs) AS PesoMs, MAX(Respos) AS Respos, ;
                       MAX(DRespos) AS DRespos, MAX(Indice) AS Indice, ;
                       MAX(TipoInvs) AS TipoInvs, ;
                       SUM(SQtds) AS SQtds, SUM(TotCusto) AS TotCusto, ;
                       SUM(TotVenda) AS TotVenda, SUM(TotMedio) AS TotMedio, ;
                       SUM(ValIcms) AS ValIcms, MAX(cotacao) AS cotacao ;
                  FROM csTempo ;
                 GROUP BY ClFiscals, CPros, lCPros, Emps, Grupos, Estos, CUnis, VlVenda ;
                  INTO CURSOR csTempo
            ENDIF

            WAIT CLEAR

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em ProcEst")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCabecalhoRelatorio - Atualiza data em CrSlvEmp para a empresa selecionada
    * Equivalente a 'visualizacao'/'impressao' do legado (parte do seek+replace)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCabecalhoRelatorio()
        LOCAL loc_cEmpresa
        loc_cEmpresa = ALLTRIM(THIS.this_cCdEmpresa)

        IF EMPTY(loc_cEmpresa)
            loc_cEmpresa = go_4c_Sistema.cCodEmpresa
        ENDIF

        IF USED("CrSigCdEmp") AND SEEK(loc_cEmpresa, "CrSigCdEmp", "CEmps")
            *-- Empresa encontrada - nada a fazer adicionalmente
        ENDIF

        IF USED("CrSlvEmp") AND SEEK(loc_cEmpresa, "CrSlvEmp", "CEmps")
            LOCAL loc_dRef
            loc_dRef = IIF(EMPTY(THIS.this_dDataSaldo), DATE(), THIS.this_dDataSaldo)
            REPLACE Datas WITH loc_dRef IN CrSlvEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoTXT - Gera arquivo de inventario no formato TXT (SPED/Costantine)
    * Equivalente ao Command1.Click do legado
    * par_dDataSaldo = data de referencia do saldo
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivoTXT(par_dDataSaldo)
        LOCAL loc_lSucesso, loc_cArq, loc_cStr, loc_cDatas, loc_cData
        LOCAL loc_cMesI, loc_cMesF, loc_dDataRef

        loc_lSucesso = .F.
        loc_dDataRef = IIF(EMPTY(par_dDataSaldo), DATE(), par_dDataSaldo)

        TRY
            *-- Prepara dados antes de gerar arquivo
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            SELECT CsTemporario
            GO TOP
            IF EOF()
                MsgAviso("Sem Movimenta" + CHR(231) + CHR(227) + "o !!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor simplificado para o arquivo TXT
            SELECT CPros, TipoInvs, VlCusto, DPros, ClFiscals, CUnis, ;
                   SUM(SQtds) AS SQtds ;
              FROM CsTemporario ;
             WHERE !EMPTY(TipoInvs) ;
             GROUP BY CPros, TipoInvs, VlCusto, DPros, ClFiscals, CUnis ;
             ORDER BY CPros ;
              INTO CURSOR cur1

            loc_cArq  = UPPER(ALLTRIM(THIS.this_cCdEmpresa)) + "_INVENTARIO.TXT"
            loc_cStr  = ""
            STRTOFILE(loc_cStr, loc_cArq, .F.)
            loc_cDatas = DTOS(loc_dDataRef)

            SELECT cur1
            GO TOP
            SCAN
                loc_cData = SUBSTR(loc_cDatas, 7, 2) + SUBSTR(loc_cDatas, 5, 2) + ;
                            SUBSTR(loc_cDatas, 1, 4)
                loc_cMesI = SUBSTR(loc_cDatas, 5, 2) + SUBSTR(loc_cDatas, 3, 2)
                loc_cMesF = SUBSTR(loc_cDatas, 5, 2) + SUBSTR(loc_cDatas, 3, 2)

                loc_cStr = loc_cData + ;
                           loc_cMesI + ;
                           loc_cMesF + ;
                           PADR(ALLTRIM(cur1.CPros), 20) + ;
                           ALLTRIM(TRANSFORM(cur1.TipoInvs, "@L 9")) + ;
                           "00000000000000" + ;
                           "00000000000000000000" + ;
                           "  " + ;
                           "     " + ;
                           ALLTRIM(TRANSFORM(cur1.SQtds, "@L 999999999.999999")) + ;
                           ALLTRIM(TRANSFORM(cur1.VlCusto, "@L 999999999999.9999")) + ;
                           ALLTRIM(TRANSFORM(ROUND(cur1.SQtds * cur1.VlCusto, 2), ;
                               "@L 99999999999999.99")) + ;
                           ALLTRIM(TRANSFORM(0.00, "@L 99999999999999.99")) + ;
                           SPACE(60) + ;
                           PADR(ALLTRIM(cur1.DPros), 80) + ;
                           "0000" + ;
                           PADR(ALLTRIM(cur1.ClFiscals), 10) + ;
                           SPACE(30) + ;
                           PADR(ALLTRIM(cur1.CUnis), 3) + ;
                           SPACE(30) + ;
                           PADR(ALLTRIM(cur1.CUnis), 6)

                STRTOFILE(loc_cStr + CHR(13) + CHR(10), loc_cArq, .T.)
            ENDSCAN

            loc_lSucesso = .T.
            MsgInfo("Arquivo gerado com sucesso: " + loc_cArq, "Invent" + CHR(225) + "rio TXT")

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao gerar TXT")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio de inventario em preview
    * Equivalente ao metodo 'visualizacao' do legado (btnReport.Visualiza)
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF


        *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        RETURN .T.
    ENDPROC

    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            THIS.AtualizarCabecalhoRelatorio()

            IF FILE(loc_cFrx)
                THIS.ExecutarReportForm("SigReIv1", "PREVIEW", THIS.this_cCursorDados)
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                         "o encontrado: " + loc_cFrx, "Relat" + CHR(243) + "rio")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio com prompt de impressora
    * Equivalente ao metodo 'impressao' do legado (btnReport.Imprime)
    * Inclui termos de abertura e encerramento (SigReIv2 e SigReIv3)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx, loc_cFrx2, loc_cFrx3
        LOCAL loc_nPaginas, loc_cTIni, loc_cTFim, loc_cPagina

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            THIS.AtualizarCabecalhoRelatorio()

            IF !FILE(loc_cFrx)
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                         "o encontrado: " + loc_cFrx, "Relat" + CHR(243) + "rio")
                loc_lSucesso = .F.
            ENDIF

            THIS.ExecutarReportForm("SigReIv1", "PRINTER_PROMPT", THIS.this_cCursorDados)
            loc_nPaginas = _PAGENO

            *-- Gera termos de abertura e encerramento
            loc_cPagina = ALLTRIM(STR(loc_nPaginas + 2))
            loc_cTIni = "CONT" + CHR(201) + "M ESTE LIVRO " + loc_cPagina + ;
                        " ( " + loc_cPagina + " ) FOLHAS NUMERADAS AUTOMATICAMENTE " + ;
                        "DE N" + CHR(176) + " 1 AO N" + CHR(176) + " " + loc_cPagina + " E "
            loc_cTFim = " PARA A ESCRITURA" + CHR(199) + CHR(195) + "O POR PROCESSAMENTO DE DADOS DOS" + ;
                        " LAN" + CHR(199) + "AMENTOS DAS OPERA" + CHR(199) + CHR(213) + "ES PR" + ;
                        CHR(211) + "PRIAS DO ESTABELECIMENTO DO CONTRIBUINTE ABAIXO IDENTIFICADO : "

            IF USED("TmpTermo")
                USE IN TmpTermo
            ENDIF
            CREATE CURSOR TmpTermo (TermoAbre m, TermoFecha m)
            INSERT INTO TmpTermo (TermoAbre, TermoFecha) ;
                VALUES (loc_cTIni + "SERVIR" + CHR(193) + loc_cTFim, ;
                        loc_cTIni + "SERVIU" + loc_cTFim)

            loc_cFrx3 = gc_4c_CaminhoReports + "SigReIv3.frx"

            SELECT TmpTermo
            IF FILE(loc_cFrx2)
                THIS.ExecutarReportForm("SigReIv2", "PRINTER_PROMPT", THIS.this_cCursorDados)
            ENDIF

            SELECT TmpTermo
            IF FILE(loc_cFrx3)
                REPORT FORM (loc_cFrx3) TO PRINTER PROMPT NOCONSOLE
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Imprime relatorio direto sem prompt de impressora
    * Equivalente ao metodo 'documento' do legado (btnReport.DocExcel)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            THIS.AtualizarCabecalhoRelatorio()

            IF !FILE(loc_cFrx)
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                         "o encontrado: " + loc_cFrx, "Relat" + CHR(243) + "rio")
                loc_lSucesso = .F.
            ENDIF

            THIS.ExecutarReportForm("SigReIv1", "PRINTER", THIS.this_cCursorDados)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
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
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao escrevem dados, sem auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
