*==============================================================================
* SIGRECPMBO.PRG
* Business Object para Relatorio de Composicao por OP (SIGRECPM)
* Herda de RelatorioBase
*
* Relatorio: Listagem de Composicao por OP (Analitico/Sintetico)
* FRX Analitico: SigReCPM.frx
* FRX Sintetico: SigReC2P.frx
* Tabelas: SigCdNei, SigCdNec, SigCdPro, SigOpPic, SigPdMvf, SigCdEmp
*==============================================================================

DEFINE CLASS SIGRECPMBO AS RelatorioBase

    *-- Filtro: Empresa
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtro: Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: Movimentacao/Operacao
    this_cOperacao      = ""

    *-- Filtro: Conta Origem
    this_cContaO        = ""
    this_cDContaO       = ""

    *-- Filtro: Conta Destino
    this_cContaD        = ""
    this_cDContaD       = ""

    *-- Filtro: Grupo Origem
    this_cGrOrigem      = ""
    this_cDsGrOrigem    = ""

    *-- Filtro: Grupo Destino
    this_cGrDestino     = ""
    this_cDsGrDestino   = ""

    *-- Filtro: Faixa de Numeros de Operacao
    this_nOperacaoI     = 0
    this_nOperacaoF     = 0

    *-- Filtro: Numero da OP
    this_nOP            = 0

    *-- Tipo de relatorio: 1=Analitico, 2=Sintetico
    this_nTipo          = 1

    *-- Flags e acumuladores (equivalentes a llope, npeso2s, npesos, nqtd do form legado)
    this_lLlope         = .F.
    this_nPeso2s        = 0
    this_nPesos         = 0
    this_nQtd           = 0

    *-- Cursor principal de dados (nome DEVE bater com alias usado nos FRXs legados:
    *--   Analitico (SigReCPM.frx): crNensi + crNensi2 + crNensi3 + dbCabecalho
    *--   Sintetico (SigReC2P.frx): crTmpNensi + dbCabecalho
    *-- Default aponta para o cursor Analitico; troca dinamica em Visualizar/Imprimir se necessario.)
    this_cCursorDados   = "crNensi"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_dDtInicial = DATE()
        THIS.this_dDtFinal   = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal e processa cursors intermediarios
    * Replica logica do PROCEDURE processamento do legado SIGRECPM
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQLEmp, loc_nResEmp, loc_cNomeEmpresa
        LOCAL loc_cTitulo, loc_cPeriodo, loc_cSubTit, loc_cNopRange
        LOCAL loc_cDtIni, loc_cDtFim
        LOCAL loc_nAno, loc_nMes, loc_nDia
        LOCAL loc_cWhere, loc_cWhereNop1, loc_cWhereNop2
        LOCAL loc_cSQL1, loc_cSQL2, loc_cSQLUnion
        LOCAL loc_nResult
        LOCAL loc_nPesos, loc_nPeso2s, loc_nQtd

        loc_lSucesso = .F.
        TRY
            *-- Busca nome da empresa quando filtrado
            loc_cNomeEmpresa = ""
            IF !EMPTY(THIS.this_cEmpresa)
                loc_cSQLEmp = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmpresa)
                loc_nResEmp = SQLEXEC(gnConnHandle, loc_cSQLEmp, "cursor_4c_SigRecPM_Emp")
                IF loc_nResEmp > 0
                    SELECT cursor_4c_SigRecPM_Emp
                    IF !EOF()
                        loc_cNomeEmpresa = ALLTRIM(Razas)
                    ENDIF
                    USE IN cursor_4c_SigRecPM_Emp
                ENDIF
            ENDIF

            *-- Monta cabecalho do relatorio (dbCabecalho usado pelo FRX)
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                                       Periodo C(150), SubTitulo C(80), ;
                                       lCompo L, Total M(4))

            loc_cTitulo = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP - " + ;
                          IIF(THIS.this_nTipo = 2, "Sint" + CHR(233) + "tico", ;
                              "Anal" + CHR(237) + "tico")

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + IIF(EMPTY(THIS.this_cEmpresa), "Geral", ;
                           THIS.this_cEmpresa + " - " + ALLTRIM(THIS.this_cDEmpresa))

            loc_cSubTit = IIF(THIS.this_nOP <> 0, ;
                              "OP: " + ALLTRIM(STR(THIS.this_nOP, 10)), "")

            IF !EMPTY(THIS.this_cOperacao)
                loc_cNopRange = ""
                IF THIS.this_nOperacaoI <> 0
                    loc_cNopRange = ":" + ALLTRIM(STR(THIS.this_nOperacaoI, 6))
                    IF THIS.this_nOperacaoF <> 0
                        loc_cNopRange = loc_cNopRange + " " + CHR(224) + " " + ;
                                        ALLTRIM(STR(THIS.this_nOperacaoF, 6))
                    ENDIF
                ENDIF
                loc_cSubTit = loc_cSubTit + IIF(!EMPTY(loc_cSubTit), " ", "") + ;
                              "Movimenta" + CHR(231) + CHR(227) + "o (" + ;
                              ALLTRIM(THIS.this_cOperacao) + loc_cNopRange + ")"
            ENDIF

            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo, SubTitulo) ;
                   VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cSubTit)

            *-- Datas para o WHERE: inicio normal, fim com 23:59:59 para cobrir dia inteiro
            loc_cDtIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_nAno   = YEAR(THIS.this_dDtFinal)
            loc_nMes   = MONTH(THIS.this_dDtFinal)
            loc_nDia   = DAY(THIS.this_dDtFinal)
            loc_cDtFim = "'" + PADL(LTRIM(STR(loc_nAno)), 4, "0") + "-" + ;
                         PADL(LTRIM(STR(loc_nMes)), 2, "0") + "-" + ;
                         PADL(LTRIM(STR(loc_nDia)), 2, "0") + " 23:59:59'"

            *-- WHERE base (compartilhado pelas duas partes do UNION)
            loc_cWhere = " WHERE b.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim
            IF !EMPTY(THIS.this_cEmpresa)
                loc_cWhere = loc_cWhere + " AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)
            ENDIF
            IF !EMPTY(THIS.this_cOperacao)
                loc_cWhere = loc_cWhere + " AND a.Dopps = " + EscaparSQL(THIS.this_cOperacao)
            ENDIF
            IF THIS.this_nOperacaoI <> 0
                loc_cWhere = loc_cWhere + " AND a.Numps >= " + ALLTRIM(STR(THIS.this_nOperacaoI))
            ENDIF
            IF THIS.this_nOperacaoF <> 0
                loc_cWhere = loc_cWhere + " AND a.Numps <= " + ALLTRIM(STR(THIS.this_nOperacaoF))
            ENDIF
            IF !EMPTY(THIS.this_cGrOrigem)
                loc_cWhere = loc_cWhere + " AND b.GrupoOs = " + EscaparSQL(THIS.this_cGrOrigem)
            ENDIF
            IF !EMPTY(THIS.this_cContaO)
                loc_cWhere = loc_cWhere + " AND b.ContaOs = " + EscaparSQL(THIS.this_cContaO)
            ENDIF
            IF !EMPTY(THIS.this_cGrDestino)
                loc_cWhere = loc_cWhere + " AND b.GrupoDs = " + EscaparSQL(THIS.this_cGrDestino)
            ENDIF
            IF !EMPTY(THIS.this_cContaD)
                loc_cWhere = loc_cWhere + " AND b.ContaDs = " + EscaparSQL(THIS.this_cContaD)
            ENDIF

            *-- WHERE para parte 1: filtra por Nops (OP direta)
            loc_cWhereNop1 = loc_cWhere
            IF THIS.this_nOP <> 0
                loc_cWhereNop1 = loc_cWhereNop1 + ;
                                 " AND a.Nops = " + ALLTRIM(STR(THIS.this_nOP))
            ENDIF

            *-- WHERE para parte 2: filtra por Nenvs (sub-ordens da OP)
            loc_cWhereNop2 = loc_cWhere
            IF THIS.this_nOP <> 0
                loc_cWhereNop2 = loc_cWhereNop2 + ;
                                 " AND (a.Nenvs = " + ALLTRIM(STR(THIS.this_nOP)) + ;
                                 " AND a.Nops <> " + ALLTRIM(STR(THIS.this_nOP)) + ")"
            ENDIF

            *-- Parte 1 do UNION: Nops como OP direta (a.Nops AS Nenvs)
            loc_cSQL1 = "SELECT DISTINCT 1 AS Tipo, a.emps, a.dopps, a.numps," + ;
                        " b.CidChaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " b.Grupoos, b.Contaos, b.grupods, b.contads,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " a.servicos, 0 AS Nops, a.cmats, c.dpros, a.Qtds,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " c.cunis, a.peso2s, c.cunips, a.Pesos,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " ISNULL(d.Cpros,'') AS Cpros, ISNULL(d.NopMaes,0) AS NopMaes,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " ISNULL(e.dpros,'') AS DescPro, f.qtds AS Qtd"
            loc_cSQL1 = loc_cSQL1 + ;
                        " FROM SigCdNei a"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigCdNec b ON a.empdnps = b.empdnps"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigCdPro c ON a.cmats = c.cpros"
            loc_cSQL1 = loc_cSQL1 + ;
                        " LEFT JOIN SigOpPic d ON a.Nops = d.Nops"
            loc_cSQL1 = loc_cSQL1 + ;
                        " LEFT JOIN SigCdPro e ON d.Cpros = e.Cpros"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigPdMvf f ON a.EmpDnPs = f.EmpDnPs"
            loc_cSQL1 = loc_cSQL1 + loc_cWhereNop1

            *-- Parte 2 do UNION: Nenvs real (sub-ordens)
            loc_cSQL2 = "SELECT DISTINCT 1 AS Tipo, a.emps, a.dopps, a.numps," + ;
                        " b.CidChaves, a.Nenvs, a.EmpDnPs, b.Datas,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " b.Grupoos, b.Contaos, b.grupods, b.contads,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " a.servicos, 0 AS Nops, a.cmats, c.dpros, a.Qtds,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " c.cunis, a.peso2s, c.cunips, a.Pesos,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " ISNULL(d.Cpros,'') AS Cpros, ISNULL(d.NopMaes,0) AS NopMaes,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " ISNULL(e.dpros,'') AS DescPro, f.qtds AS Qtd"
            loc_cSQL2 = loc_cSQL2 + ;
                        " FROM SigCdNei a"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigCdNec b ON a.empdnps = b.empdnps"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigCdPro c ON a.cmats = c.cpros"
            loc_cSQL2 = loc_cSQL2 + ;
                        " LEFT JOIN SigOpPic d ON a.Nops = d.Nops"
            loc_cSQL2 = loc_cSQL2 + ;
                        " LEFT JOIN SigCdPro e ON d.Cpros = e.Cpros"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigPdMvf f ON a.EmpDnPs = f.EmpDnPs"
            loc_cSQL2 = loc_cSQL2 + loc_cWhereNop2

            loc_cSQLUnion = loc_cSQL1 + " UNION " + loc_cSQL2

            *-- Executa query principal no SQL Server
            IF USED("TmpNensi")
                USE IN TmpNensi
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLUnion, "TmpNensi")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE

            *-- Agrupa por material/OP para eliminar duplicatas e calcular totais
            IF USED("crNensi")
                USE IN crNensi
            ENDIF
            SELECT Tipo, Nenvs, dopps, cpros, descpro, cmats, dpros, cunis, cunips, ;
                   MAX(cidchaves) AS cidchaves, MAX(pesos) AS pesos, ;
                   MAX(peso2s) AS peso2s, MAX(qtds) AS Qtds, MAX(qtd) AS qtd ;
                   FROM TmpNensi ;
                   GROUP BY Tipo, Nenvs, dopps, cpros, descpro, cmats, dpros, cunis, cunips ;
                   INTO CURSOR crNensi READWRITE

            SELECT crNensi
            INDEX ON STR(nenvs, 10) + STR(Tipo) + cidchaves + dopps + cmats TAG Mov
            GO TOP

            *-- Agrega por material para calcular totais de peso
            IF USED("crNensi2")
                USE IN crNensi2
            ENDIF
            SELECT 2 AS Tipo, nenvs, cmats, MAX(pesos) AS pesos, ;
                   MAX(peso2s) AS peso2s, MAX(qtds) AS Qtds ;
                   FROM crNensi ;
                   GROUP BY Nenvs, cmats ;
                   INTO CURSOR crNensi2 READWRITE

            SELECT crNensi2
            loc_nPesos  = 0
            loc_nPeso2s = 0
            SUM pesos, peso2s TO loc_nPesos, loc_nPeso2s
            THIS.this_nPesos  = loc_nPesos
            THIS.this_nPeso2s = loc_nPeso2s

            *-- Agrega por OP para calcular total de quantidade
            IF USED("crNensi3")
                USE IN crNensi3
            ENDIF
            SELECT 3 AS Tipo, nenvs, MAX(qtd) AS Qtd ;
                   FROM crNensi ;
                   GROUP BY Nenvs ;
                   INTO CURSOR crNensi3 READWRITE

            SELECT crNensi3
            loc_nQtd = 0
            SUM Qtd TO loc_nQtd
            THIS.this_nQtd = loc_nQtd

            *-- Modo Sintetico: reagrupa por material eliminando detalhe de OP
            IF THIS.this_nTipo = 2
                IF USED("crTmpNensi")
                    USE IN crTmpNensi
                ENDIF
                SELECT 9 AS Tipo, '' AS Dopps, cmats, dpros, cunips, cunis, ;
                       0 AS Qtd, SUM(qtds) AS Qtds, SUM(pesos) AS pesos, ;
                       SUM(peso2s) AS peso2s ;
                       FROM crNensi ;
                       GROUP BY cmats, dpros, cunis, cunips ;
                       ORDER BY cmats ;
                       INTO CURSOR crTmpNensi READWRITE

                SELECT crTmpNensi
                GO TOP
            ELSE
                SELECT crNensi
                GO TOP
            ENDIF

            THIS.this_lLlope = EMPTY(THIS.this_cOperacao)

            loc_lSucesso = .T.
            ENDIF  && loc_nResult >= 1
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados - SIGRECPMBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
    *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
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

        *-- Isolamento de locale + modo de renderizacao (Erro28)
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
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipo = 1
                    THIS.ExecutarReportForm("SigReCPM", "PREVIEW", THIS.this_cCursorDados)
                ELSE
                    THIS.ExecutarReportForm("SigReC2P", "PREVIEW", THIS.this_cCursorDados)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar - SIGRECPMBO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipo = 1
                    REPORT FORM (gc_4c_CaminhoReports + "SigReCPM.frx") ;
                           TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + "SigReC2P.frx") ;
                           TO PRINTER PROMPT NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir - SIGRECPMBO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor
    * Util para restaurar conjuntos de filtros salvos (presets)
    * O cursor deve conter colunas com os mesmos nomes dos filtros do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Empresa
            IF TYPE(par_cAliasCursor + ".Emps") != "U"
                THIS.this_cEmpresa = TratarNulo(Emps, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DEmps") != "U"
                THIS.this_cDEmpresa = TratarNulo(DEmps, "C")
            ENDIF

            *-- Periodo
            IF TYPE(par_cAliasCursor + ".DtIni") != "U"
                THIS.this_dDtInicial = TratarNulo(DtIni, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DtFim") != "U"
                THIS.this_dDtFinal = TratarNulo(DtFim, "D")
            ENDIF

            *-- Operacao
            IF TYPE(par_cAliasCursor + ".Dopps") != "U"
                THIS.this_cOperacao = TratarNulo(Dopps, "C")
            ENDIF

            *-- Contas
            IF TYPE(par_cAliasCursor + ".Contaos") != "U"
                THIS.this_cContaO = TratarNulo(Contaos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DContaO") != "U"
                THIS.this_cDContaO = TratarNulo(DContaO, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Contads") != "U"
                THIS.this_cContaD = TratarNulo(Contads, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DContaD") != "U"
                THIS.this_cDContaD = TratarNulo(DContaD, "C")
            ENDIF

            *-- Grupos
            IF TYPE(par_cAliasCursor + ".Grupoos") != "U"
                THIS.this_cGrOrigem = TratarNulo(Grupoos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DGrupoOs") != "U"
                THIS.this_cDsGrOrigem = TratarNulo(DGrupoOs, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Grupods") != "U"
                THIS.this_cGrDestino = TratarNulo(Grupods, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DGrupoDs") != "U"
                THIS.this_cDsGrDestino = TratarNulo(DGrupoDs, "C")
            ENDIF

            *-- Faixa de Operacao
            IF TYPE(par_cAliasCursor + ".NumPsI") != "U"
                THIS.this_nOperacaoI = TratarNulo(NumPsI, "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".NumPsF") != "U"
                THIS.this_nOperacaoF = TratarNulo(NumPsF, "N")
            ENDIF

            *-- OP
            IF TYPE(par_cAliasCursor + ".Nops") != "U"
                THIS.this_nOP = TratarNulo(Nops, "N")
            ENDIF

            *-- Tipo
            IF TYPE(par_cAliasCursor + ".TipoRel") != "U"
                THIS.this_nTipo = TratarNulo(TipoRel, "N")
                IF THIS.this_nTipo < 1 OR THIS.this_nTipo > 2
                    THIS.this_nTipo = 1
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor - SIGRECPMBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao NAO aplicavel para BOs de relatorio
    * Relatorios nao persistem registros; existem apenas para gerar saida.
    * Sobrescreve para garantir que chamadas indevidas vindas de codigo
    * generico (sweepers, framework) falhem com mensagem clara e auditavel.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inclus" + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + "vel para o relat" + ;
                                  CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao NAO aplicavel para BOs de relatorio
    * (mesma justificativa de Inserir())
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + ;
                                  CHR(227) + "o n" + CHR(227) + "o aplic" + CHR(225) + "vel para o relat" + ;
                                  CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do conjunto de filtros atual
    * Relatorios nao tem chave de registro - usa-se o hash dos filtros
    * para identificar a execucao (util em auditoria/log).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECPM|" + ;
                     ALLTRIM(THIS.this_cEmpresa) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cOperacao) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOperacaoI, 10)) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOperacaoF, 10)) + "|" + ;
                     ALLTRIM(THIS.this_cContaO) + "|" + ;
                     ALLTRIM(THIS.this_cContaD) + "|" + ;
                     ALLTRIM(THIS.this_cGrOrigem) + "|" + ;
                     ALLTRIM(THIS.this_cGrDestino) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOP, 10)) + "|" + ;
                     ALLTRIM(STR(THIS.this_nTipo, 2))
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na auditoria
    * par_cOperacao: "VISUALIZAR" ou "IMPRIMIR"
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cChave, loc_cUsuario
        LOCAL loc_cOperacao, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cOperacao = IIF(EMPTY(par_cOperacao), "EXECUTAR", UPPER(ALLTRIM(par_cOperacao)))

            loc_cChave    = THIS.ObterChavePrimaria()
            loc_cUsuario  = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                                gc_4c_UsuarioLogado, "SYSTEM")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora)" + ;
                       " VALUES (" + EscaparSQL("SIGRECPM") + ", " + ;
                       EscaparSQL(loc_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar auditoria do relat" + ;
                                          CHR(243) + "rio"
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nunca deve interromper o relatorio; apenas registra erro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
