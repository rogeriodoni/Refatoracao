*==============================================================================
* SIGREHCPBO.PRG
* BO para Relatorio de Historico de Custo de Produtos
* Relatorios: SigRehc1.frx / SigRehc2.frx / SigRehc3.frx
*
* Filtros:
*   - Empresa (CEmps/DEmps) - apenas quando CalcCustos <> 1
*   - Produto (CPros/DPros)
*   - Periodo (DtInicial / DtFinal)
*   - TipoImps: 1=Relacao Padrao, 2=Modelo 3
*
* CalcCustos lido de SigCdPaC.calccustos:
*   1 = por Produto apenas (SigRehc2)
*   outros = por Empresa+Produto (SigRehc1)
*==============================================================================

DEFINE CLASS SIGREHCPBO AS RelatorioBase

    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_cCPros         = ""
    this_cDPros         = ""
    this_cCEmps         = ""
    this_cDEmps         = ""
    this_nTipoImps      = 1
    this_nCalcCustos    = 0

    *-- Pattern #142: injetado pelo CorretorAutomatico (default vazio) - REVISAR e substituir pelo alias do cursor binding do FRX
    this_cCursorDados = "crImpressao"   && cursor lido pelos FRX SigRehc1/2/3 (Erro366)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.ObterParametros()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterParametros - Le CalcCustos da tabela SigCdPaC
    *--------------------------------------------------------------------------
    PROCEDURE ObterParametros()
        LOCAL loc_cSQL, loc_nResult
        TRY
            loc_cSQL = "SELECT TOP 1 calccustos FROM SigCdPaC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param")
            IF loc_nResult > 0
                SELECT cursor_4c_Param
                IF !EOF()
                    THIS.this_nCalcCustos = NVL(calccustos, 0)
                ENDIF
                USE IN cursor_4c_Param
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos de filtro antes de imprimir
    * Retorna "" se OK, ou nome do campo com erro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_cErro
        loc_cErro = ""

        IF EMPTY(THIS.this_dDtInicial)
            loc_cErro = "DataInicial"
        ELSE
            IF EMPTY(THIS.this_dDtFinal)
            loc_cErro = "DataFinal"
        ELSE
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
            loc_cErro = "Periodo"
            ENDIF
            ENDIF
        ENDIF

        RETURN loc_cErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Transcricao de cnSigReHcp.Processamento (legado sigrehcp.prg)
    *   1. crCabecalho (Titulo/SubTit/Empresa)    -> lido pelos FRX
    *   2. crImpressao com o indice "Ordem" do tipo/calculo de custo
    *   3. SelecDados: movimentos de SigMvHst no periodo + produto + NF
    *   O cursor crImpressao fica SELECIONADO e no topo (REPORT FORM usa o alias
    *   corrente). Antes o BO lia colunas de preco de SigCdPro, que nao eh o que o
    *   relatorio mostra, num cursor que nenhum FRX conhece (Erro366).
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        TRY
            THIS.CriarCabecalho()
            THIS.CriarCursores()
            IF THIS.SelecDados()
                SELECT crImpressao
                GO TOP
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCabecalho - cnSigReHcp.CriarCabecalho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCabecalho()
        LOCAL loc_cTit, loc_cSub, loc_cDep, loc_cEmpr
        IF THIS.this_nTipoImps = 1
            loc_cTit = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + "rico de Custo de Produtos"
            loc_cSub = "Per" + CHR(237) + "odo : " + DTOC(THIS.this_dDtInicial) + " a " + ;
                       DTOC(THIS.this_dDtFinal) + " " + ;
                       IIF(EMPTY(THIS.this_cCPros), "", " - Produto : " + ALLTRIM(THIS.this_cCPros)) + ;
                       IIF(THIS.this_nCalcCustos = 1, "", ;
                           IIF(EMPTY(THIS.this_cCEmps), "", " - Empresa : " + ALLTRIM(THIS.this_cCEmps)))
        ELSE
            loc_cTit = "Registro de Controle da Produ" + CHR(231) + CHR(227) + "o e do Estoque"
            loc_cSub = "Per" + CHR(237) + "odo : " + DTOC(THIS.this_dDtInicial) + " a " + ;
                       DTOC(THIS.this_dDtFinal)
        ENDIF

        *-- Legado usa _Empr (proibido no projeto) -> go_4c_Sistema.cCodEmpresa
        loc_cEmpr = go_4c_Sistema.cCodEmpresa
        loc_cDep  = ""
        IF SQLEXEC(gnConnHandle, "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                   EscaparSQL(loc_cEmpr), "cursor_4c_EmpCab") > 0
            IF !EOF("cursor_4c_EmpCab")
                loc_cDep = loc_cEmpr + " - " + ALLTRIM(cursor_4c_EmpCab.Razas)
            ENDIF
            USE IN cursor_4c_EmpCab
        ENDIF

        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        CREATE CURSOR crCabecalho (Titulo C(200), SubTit C(200), Empresa C(80))
        INSERT INTO crCabecalho (Titulo, SubTit, Empresa) VALUES (loc_cTit, loc_cSub, loc_cDep)
        GO TOP IN crCabecalho
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursores - cnSigReHcp.CriarCursores (estrutura e indice EXATOS)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursores()
        IF USED("crImpressao")
            USE IN crImpressao
        ENDIF
        CREATE CURSOR crImpressao (Emps C(3), CPros C(14), DPros C(40), CUnis C(3), Datas D(8), ;
            Dopes C(20), Numes N(6), Qtds N(10,3), Opers C(1), Sqtds N(12,3), ;
            Units N(16,6), AliqIcms N(6,2), Aliqs N(5,2), ValIpis N(5,2), ;
            Moedas C(3), UnitMeds N(16,6), UnitMFis N(16,6), MoedMeds C(3), ;
            cIdChaves C(20), EspecieNFs C(6), Series C(8), NFis C(6), ;
            Emis D(8), ClFiscals C(10))

        SELECT crImpressao
        IF THIS.this_nTipoImps = 1
            IF THIS.this_nCalcCustos = 1
                INDEX ON CPros + cIdChaves TAG Ordem
            ELSE
                INDEX ON Emps + CPros + cIdChaves TAG Ordem
            ENDIF
        ELSE
            IF THIS.this_nCalcCustos = 1
                INDEX ON DPros + CPros + cIdChaves TAG Ordem
            ELSE
                INDEX ON Emps + DPros + CPros + cIdChaves TAG Ordem
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecDados - cnSigReHcp.SelecDados (regra transcrita linha a linha)
    *   - movimentos de SigMvHst entre as datas (fDtoSql, como o legado)
    *   - Units soma o ICMS-ST do item (Icmss / Qtds) quando o item casa
    *   - AliqIcms/Aliqs/ValIpis do 1o item da operacao com o mesmo Opers
    *   - Sqtds = saldo acumulado (E soma, S subtrai) na ordem do indice, SEM
    *     zerar por produto - exatamente como o legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SelecDados()
        LOCAL loc_cQuery, loc_nSqt, loc_nQtds, loc_nTotal, loc_nAtual, loc_lOk
        PRIVATE pDtI, pDtF
        loc_lOk = .T.

        pDtI = fDtoSql(THIS.this_dDtInicial)
        pDtF = fDtoSql(THIS.this_dDtFinal)

        loc_cQuery = "SELECT a.Emps, a.CPros, b.DPros, b.CUnis, a.Datas, a.Dopes, a.Numes, a.Qtds, " + ;
                     "a.Opers, a.Sqtds, a.Units, a.Moedas, a.UnitMeds, a.UnitMFis, a.MoedMeds, " + ;
                     "a.cIdChaves, c.EspecieNFs, c.Series, c.NFis, c.Emis, b.ClFiscals " + ;
                     "FROM SigCdPro b, SigMvHst a " + ;
                     "LEFT JOIN SigMvNfi c ON c.EmpDopNums = a.EmpDopNums " + ;
                     "WHERE a.Datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                     IIF(EMPTY(THIS.this_cCPros), "", ;
                         "a.CPros = " + EscaparSQL(PADR(THIS.this_cCPros, 14)) + " AND ") + ;
                     IIF(THIS.this_nCalcCustos = 1, "", ;
                         IIF(EMPTY(THIS.this_cCEmps), "", ;
                             "a.Emps = " + EscaparSQL(PADR(THIS.this_cCEmps, 3)) + " AND ")) + ;
                     "a.CPros = b.CPros " + ;
                     "ORDER BY " + IIF(THIS.this_nCalcCustos = 1, "", "a.Emps, ") + "a.CPros, a.cIdChaves"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigReHcp_Dados") < 1
            MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (SelecDados - crSigReHcp_Dados)")
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            loc_nTotal = RECCOUNT("crSigReHcp_Dados")
            loc_nAtual = 0
            SELECT crSigReHcp_Dados
            SCAN
                loc_nAtual = loc_nAtual + 1
                WAIT WINDOW "Processando Custos... " + TRANSFORM(loc_nAtual) + "/" + ;
                    TRANSFORM(loc_nTotal) + "  Produto : " + ALLTRIM(crSigReHcp_Dados.CPros) NOWAIT

                SCATTER MEMVAR
                m.EspecieNFs = NVL(m.EspecieNFs, "")
                m.Series     = NVL(m.Series, "")
                m.NFis       = NVL(m.NFis, "")
                m.Emis       = NVL(m.Emis, {})
                INSERT INTO crImpressao FROM MEMVAR

                loc_cQuery = "SELECT CItens, Opers, CPros, Units, AliqIcms, Aliqs, IcmsS, Totas, Qtds, ValIpis " + ;
                             "FROM SigMvItn " + ;
                             "WHERE EmpDopNums = " + EscaparSQL(m.Emps + m.Dopes + STR(m.Numes, 6)) + ;
                             " AND CPros = " + EscaparSQL(m.CPros) + ;
                             " ORDER BY CItens"
                IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigReHcp_EstI") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SelecDados - crSigReHcp_EstI)")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                SELECT crSigReHcp_EstI
                SCAN
                    IF crSigReHcp_EstI.Opers = m.Opers
                        REPLACE AliqIcms WITH crSigReHcp_EstI.AliqIcms, ;
                                Aliqs    WITH crSigReHcp_EstI.Aliqs, ;
                                ValIpis  WITH crSigReHcp_EstI.ValIpis IN crImpressao
                        GO BOTTOM IN crSigReHcp_EstI
                    ENDIF
                ENDSCAN

                SELECT crSigReHcp_EstI
                SCAN
                    loc_nQtds = crSigReHcp_Dados.Qtds
                    IF (crSigReHcp_Dados.Qtds = 0 AND crSigReHcp_EstI.Totas = crSigReHcp_Dados.Units) OR ;
                       (crSigReHcp_Dados.Qtds = crSigReHcp_EstI.Qtds AND crSigReHcp_EstI.Units = crSigReHcp_Dados.Units)
                        REPLACE Units WITH Units + (crSigReHcp_EstI.Icmss / IIF(loc_nQtds = 0, 1, loc_nQtds)) IN crImpressao
                        GO BOTTOM IN crSigReHcp_EstI
                    ENDIF
                ENDSCAN
                SELECT crSigReHcp_Dados
            ENDSCAN
            WAIT CLEAR
        ENDIF

        IF loc_lOk
            loc_nSqt = 0
            SELECT crImpressao
            SCAN
                loc_nSqt = loc_nSqt + (crImpressao.Qtds * IIF(crImpressao.Opers = "E", 1, -1))
                REPLACE Sqtds WITH loc_nSqt IN crImpressao
            ENDSCAN
        ENDIF

        IF USED("crSigReHcp_EstI")
            USE IN crSigReHcp_EstI
        ENDIF
        IF USED("crSigReHcp_Dados")
            USE IN crSigReHcp_Dados
        ENDIF
        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCaminhoRelatorio - Determina qual FRX usar conforme filtros
    *   TipoImps=1: CalcCustos=1 -> SigRehc2 (Produto) | outro -> sigrehc1 (Emp+Prod)
    *   TipoImps=2 -> SigRehc3 (Modelo 3 Livro Fiscal)
    *--------------------------------------------------------------------------
    PROCEDURE ObterCaminhoRelatorio()
        LOCAL loc_cArquivo
        IF THIS.this_nTipoImps = 1
            IF THIS.this_nCalcCustos = 1
                loc_cArquivo = "SigRehc2"
            ELSE
                loc_cArquivo = "sigrehc1"
            ENDIF
        ELSE
            loc_cArquivo = "SigRehc3"
        ENDIF
        RETURN gc_4c_CaminhoReports + loc_cArquivo + ".frx"
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir / Visualizar - legado: Set Point To [,] + REPORT FORM.
    *   ReportFormIsolado(..., .T.) = POINT "," + REPORTBEHAVIOR 80 (FRX legado)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT crImpressao
                GO TOP
                THIS.ReportFormIsolado(THIS.ObterCaminhoRelatorio(), "PRINTER_PROMPT", "", .T.)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT crImpressao
                GO TOP
                THIS.ReportFormIsolado(THIS.ObterCaminhoRelatorio(), "PREVIEW", "", .T.)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC
    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC


    *--------------------------------------------------------------------------
    * GerarExcel - Exporta relatorio para arquivo ASCII (Excel) (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "SIGREHCP_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    THIS.ReportFormIsolado(THIS.ObterCaminhoRelatorio(), "ASCII", loc_cArquivo, .T.)
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
