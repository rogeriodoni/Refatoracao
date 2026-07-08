*==============================================================================
* SIGREATOBO.PRG
* Business Object - Relatorio de Analise de Estoque Por Tipo de Operacao
*
* Herda de RelatorioBase
* Tabelas: SigMvHst (movimentos), SigCdOpe (operacoes), SigCdTom (tipos),
*          SigCdPro (produtos), SigCdGrp (grupos), SigCdCeg (contas estoque)
* Relatorios: SigReAto.frx (sem imagem) / SigReAtu.frx (com imagem)
*==============================================================================

DEFINE CLASS sigreatoBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial            = {}
    this_dDtFinal              = {}

    *-- Filtro de grupo (SigCdGrp - CGrus/DGrus, MaxLength=3)
    this_cGrupo                = ""
    this_cDGrupo               = ""

    *-- Filtro de produto (SigCdPro - CPros/DPros, MaxLength=14)
    this_cCPros                = ""
    this_cDPros                = ""

    *-- Filtro de linha (SigCdLin - Linhas/Descs, MaxLength=10)
    this_cLin                  = ""
    this_cDLin                 = ""

    *-- Filtro de fornecedor (MaxLength=10 codigo, MaxLength=40 descricao)
    this_cFornecedor           = ""
    this_cDFornecedor          = ""

    *-- Opcao de imagem: .T.=Com Imagem (optImagem.Value=1), .F.=Sem Imagem
    this_lImagem               = .F.

    *-- Tipo de relatorio: 1=Analitico, 2=Sintetico (optTipos)
    this_nTipos                = 1

    *-- Filtro de diferencas: 1=Ignorar, 2=Sem Diferenca, 3=Positiva, 4=Negativa
    this_nDiferenca            = 1

    *-- Mensagem de validacao de parametros (TrataErro do legado)
    this_cTrataErro            = ""

    *-- Cursor principal de saida do relatorio
    this_cCursorDados          = "crImpressao"

    *-- Nomes dos cursores de referencia carregados em InicializarDados
    this_cCursorOperacoesE     = "cursor_4c_OperacoesE"
    this_cCursorOperacoesS     = "cursor_4c_OperacoesS"
    this_cCursorSigCdCeg       = "cursor_4c_SigCdCeg"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO com valores padrao identicos ao legado
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_dDtInicial = DATE()
        THIS.this_dDtFinal   = DATE()
        THIS.this_nTipos     = 1
        THIS.this_nDiferenca = 1
        THIS.this_lImagem    = .F.
        THIS.this_cTrataErro = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(7), loc_nI
        loc_aCursors(1) = "cursor_4c_OperacoesE"
        loc_aCursors(2) = "cursor_4c_OperacoesS"
        loc_aCursors(3) = "cursor_4c_SigCdCeg"
        loc_aCursors(4) = "crImpressao"
        loc_aCursors(5) = "cursor_4c_Prods"
        loc_aCursors(6) = "cursor_4c_Entradas"
        loc_aCursors(7) = "cursor_4c_Saidas"
        FOR loc_nI = 1 TO 7
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursores de referencia usados pelo Form
    * Chamado no InicializarForm() do Formsigreato.
    * Cria:
    *   cursor_4c_OperacoesE : SelImp L, Codigos N(2), Descrs C(30)
    *     pre-seleciona Codigos=3 (entrada padrao)
    *   cursor_4c_OperacoesS : SelImp L, Codigos N(2), Descrs C(30)
    *     pre-seleciona Codigos=6 (saida padrao)
    *   cursor_4c_SigCdCeg   : lMarca L, Grupos C(10), Contas C(10)
    *     todos com lMarca=.F. (usuario marca quais incluir)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- 1. Tipos de operacao (SigCdTom) -> cursor_4c_OperacoesE e cursor_4c_OperacoesS
            IF USED("cursor_4c_TomTmp")
                USE IN cursor_4c_TomTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos", ;
                "cursor_4c_TomTmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar Tipos de Opera" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_OperacoesE")
                USE IN cursor_4c_OperacoesE
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_OperacoesE (SelImp L(1), Codigos N(2,0), Descrs C(30))
            SET NULL OFF
            INDEX ON Codigos TAG Codigos

            IF USED("cursor_4c_OperacoesS")
                USE IN cursor_4c_OperacoesS
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_OperacoesS (SelImp L(1), Codigos N(2,0), Descrs C(30))
            SET NULL OFF
            INDEX ON Codigos TAG Codigos

            SELECT cursor_4c_TomTmp
            GO TOP
            SCAN
                *-- Tipos=3 pre-selecionados em Entrada, Tipos=6 em Saida (padrao legado)
                INSERT INTO cursor_4c_OperacoesE (SelImp, Codigos, Descrs) ;
                    VALUES (cursor_4c_TomTmp.Codigos = 3, cursor_4c_TomTmp.Codigos, ;
                            ALLTRIM(cursor_4c_TomTmp.Descrs))
                INSERT INTO cursor_4c_OperacoesS (SelImp, Codigos, Descrs) ;
                    VALUES (cursor_4c_TomTmp.Codigos = 6, cursor_4c_TomTmp.Codigos, ;
                            ALLTRIM(cursor_4c_TomTmp.Descrs))
            ENDSCAN
            USE IN cursor_4c_TomTmp

            GO TOP IN cursor_4c_OperacoesE
            GO TOP IN cursor_4c_OperacoesS

            *-- 2. Contas de estoque (SigCdCeg) -> cursor_4c_SigCdCeg
            IF USED("cursor_4c_CegTmp")
                USE IN cursor_4c_CegTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Grupos, Contas FROM SigCdCeg ORDER BY Grupos, Contas", ;
                "cursor_4c_CegTmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar Contas de Estoque (SigCdCeg)"
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigCdCeg")
                USE IN cursor_4c_SigCdCeg
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_SigCdCeg (lMarca L(1), Grupos C(10), Contas C(10))
            SET NULL OFF
            INDEX ON Grupos + Contas TAG GruContas

            SELECT cursor_4c_CegTmp
            GO TOP
            SCAN
                INSERT INTO cursor_4c_SigCdCeg (lMarca, Grupos, Contas) ;
                    VALUES (.F., ALLTRIM(cursor_4c_CegTmp.Grupos), ALLTRIM(cursor_4c_CegTmp.Contas))
            ENDSCAN
            USE IN cursor_4c_CegTmp

            SELECT cursor_4c_SigCdCeg
            SET ORDER TO TAG GruContas
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Valida entradas antes de PrepararDados
    * Preenche this_cTrataErro com identificador do erro (equivale ao
    * ValidaBotoes/loObj.TrataErro do legado).
    * Retorna .T. se OK, .F. se ha erro (mensagem em this_cTrataErro).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarParametros()
        THIS.this_cTrataErro = ""

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cTrataErro = "DataInicial"
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cTrataErro = "DataFinal"
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cTrataErro = "Final < Inicial"
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarListaTipos - Constroi string "(cod1,cod2,...)" de Codigos marcados
    * par_cCursor: nome do cursor (cursor_4c_OperacoesE ou cursor_4c_OperacoesS)
    * Retorna string IN ex: "(3,6)" ou "" se nenhum selecionado
    *--------------------------------------------------------------------------
    PROCEDURE MontarListaTipos(par_cCursor)
        LOCAL loc_cLista

        loc_cLista = ""

        IF !USED(par_cCursor)
            RETURN ""
        ENDIF

        SELECT (par_cCursor)
        GO TOP
        SCAN
            IF SelImp
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                             ALLTRIM(STR(Codigos, 2))
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cLista)
            loc_cLista = "(" + loc_cLista + ")"
        ENDIF

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarListaContas - Constroi string de contas marcadas em cursor_4c_SigCdCeg
    * Retorna string IN ex: "('GRP1ACC1','GRP2ACC2')" ou "" se nenhuma marcada
    *--------------------------------------------------------------------------
    PROCEDURE MontarListaContas()
        LOCAL loc_cLista

        loc_cLista = ""

        IF !USED("cursor_4c_SigCdCeg")
            RETURN ""
        ENDIF

        SELECT cursor_4c_SigCdCeg
        GO TOP
        SCAN
            IF lMarca
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                             "'" + ALLTRIM(Grupos) + ALLTRIM(Contas) + "'"
            ENDIF
        ENDSCAN

        IF !EMPTY(loc_cLista)
            loc_cLista = "(" + loc_cLista + ")"
        ENDIF

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento completo gerando cursor crImpressao
    *
    * Estrutura de crImpressao (por produto):
    *   Linha header (Ordem='0000000001'): dados do produto, Entradas, Saidas
    *   Linhas conta (Ordem='0000000002',...): Estos=Grupo+Conta, Estoques=saldo liq
    *   Linha total  (Estos='Total :   '): soma de Estoques, Diferencas
    *
    * Entradas = soma Qtds em SigMvHst onde TipoOps (via SigCdOpe) in E-selecionados
    * Saidas   = soma Qtds em SigMvHst onde TipoOps (via SigCdOpe) in S-selecionados
    * Estoques = saldo liquido por conta (SigMvHst: E+qtd, S-qtd) no periodo
    * Diferencas = Entradas - Saidas - SUM(Estoques por conta)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cEmp, loc_cDtI, loc_cDtF
        LOCAL loc_cInCodE, loc_cInCodS, loc_cInContas
        LOCAL loc_nResult, loc_cSQL, loc_cWhere
        LOCAL loc_nEntradas, loc_nSaidas, loc_nTotalEst, loc_nDif
        LOCAL loc_nOrdem, loc_cCPros
        LOCAL loc_nEstCount, loc_nEstLine

        loc_lSucesso = .F.

        TRY
            *-- Validar parametros
            IF !THIS.ValidarParametros()
                loc_lSucesso = .F.
            ENDIF

            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cDtI = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)

            *-- Montar listas de tipos selecionados
            loc_cInCodE = THIS.MontarListaTipos("cursor_4c_OperacoesE")
            IF EMPTY(loc_cInCodE)
                THIS.this_cMensagemErro = "Nenhum Tipo de Opera" + CHR(231) + CHR(227) + ;
                                          "o de Entrada Foi Selecionado!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_cInCodS = THIS.MontarListaTipos("cursor_4c_OperacoesS")
            IF EMPTY(loc_cInCodS)
                THIS.this_cMensagemErro = "Nenhum Tipo de Opera" + CHR(231) + CHR(227) + ;
                                          "o de Sa" + CHR(237) + "da Foi Selecionado!!!"
                loc_lSucesso = .F.
            ENDIF

            loc_cInContas = THIS.MontarListaContas()

            *-- Recriar crImpressao
            IF USED("crImpressao")
                USE IN crImpressao
            ENDIF
            CREATE CURSOR crImpressao (CPros C(14), DPros C(40), Reffs C(15), ;
                CGrus C(3), Linhas C(10), IFors C(10), Ordem C(10), ;
                Estos C(30), Imagem M, Pvens N(14,2), Moevs C(3), ;
                Entradas N(14,3), Saidas N(14,3), Grupos C(30), ;
                Margems N(9,6), Estoques N(14,3), Diferencas N(14,3))

            *-- Limpar cursores temporarios de execucao anterior
            LOCAL loc_aTmp(4), loc_nT
            loc_aTmp(1) = "cursor_4c_Prods"
            loc_aTmp(2) = "cursor_4c_Entradas"
            loc_aTmp(3) = "cursor_4c_Saidas"
            loc_aTmp(4) = "cursor_4c_EstContas"
            FOR loc_nT = 1 TO 4
                IF USED(loc_aTmp(loc_nT))
                    USE IN (loc_aTmp(loc_nT))
                ENDIF
            ENDFOR

            *-- Query 1: Produtos com movimentos no periodo (E ou S selecionados)
            loc_cSQL = "SELECT DISTINCT p.CPros, p.DPros, p.Reffs, p.CGrus, p.Linhas," + ;
                       " p.IFors, p.Pvens, p.Moevs, p.Margems," + ;
                       " ISNULL(g.DGrus,'') AS DGrus" + ;
                       " FROM SigCdPro p" + ;
                       " LEFT JOIN SigCdGrp g ON g.CGrus = p.CGrus" + ;
                       " WHERE p.CPros IN" + ;
                       " (SELECT h.Cpros FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodE + ;
                       " UNION" + ;
                       " SELECT h.Cpros FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodS + ")"

            *-- Filtros adicionais de produto
            IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                loc_cSQL = loc_cSQL + ;
                           " AND p.CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCPros))
                loc_cSQL = loc_cSQL + ;
                           " AND p.CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cLin))
                loc_cSQL = loc_cSQL + ;
                           " AND p.Linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLin))
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
                loc_cSQL = loc_cSQL + ;
                           " AND p.IFors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecedor))
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY p.DPros, p.CPros"

            WAIT WINDOW "Selecionando produtos..." NOWAIT
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prods")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar produtos"
                loc_lSucesso = .F.
            ENDIF

            *-- Query 2: Total Entradas por produto (tipos E selecionados)
            loc_cSQL = "SELECT h.Cpros, SUM(h.Qtds) AS Total" + ;
                       " FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodE + ;
                       " GROUP BY h.Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Entradas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular entradas"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Entradas")
                SELECT cursor_4c_Entradas
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- Query 3: Total Saidas por produto (tipos S selecionados)
            loc_cSQL = "SELECT h.Cpros, SUM(h.Qtds) AS Total" + ;
                       " FROM SigMvHst h" + ;
                       " INNER JOIN SigCdOpe o ON h.Dopes = o.Dopes" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                       " AND CAST(o.TipoOps AS INT) IN " + loc_cInCodS + ;
                       " GROUP BY h.Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Saidas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular sa" + CHR(237) + "das"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Saidas")
                SELECT cursor_4c_Saidas
                INDEX ON Cpros TAG Cpros
            ENDIF

            *-- Query 4: Saldo liquido por produto/conta no periodo
            loc_cSQL = "SELECT h.Cpros, h.Grupos, h.Estos," + ;
                       " SUM(IIF(h.Opers='E', h.Qtds, -h.Qtds)) AS Estoques" + ;
                       " FROM SigMvHst h" + ;
                       " WHERE h.Emps = " + EscaparSQL(loc_cEmp) + ;
                       " AND h.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF

            IF !EMPTY(loc_cInContas)
                loc_cSQL = loc_cSQL + ;
                           " AND (RTRIM(h.Grupos) + RTRIM(h.Estos)) IN " + loc_cInContas
            ENDIF
            loc_cSQL = loc_cSQL + " GROUP BY h.Cpros, h.Grupos, h.Estos" + ;
                                  " ORDER BY h.Cpros, h.Grupos, h.Estos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstContas")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao calcular saldo de estoques"
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_EstContas")
                SELECT cursor_4c_EstContas
                INDEX ON Cpros TAG Cpros
                GO TOP
            ENDIF

            *-- Iterar produtos e montar crImpressao
            WAIT WINDOW "Processando relat" + CHR(243) + "rio..." NOWAIT

            SELECT cursor_4c_Prods
            GO TOP

            SCAN
                loc_cCPros = PADR(ALLTRIM(cursor_4c_Prods.CPros), 14)

                *-- Entradas deste produto
                loc_nEntradas = 0
                IF USED("cursor_4c_Entradas")
                    SELECT cursor_4c_Entradas
                    IF SEEK(loc_cCPros, "cursor_4c_Entradas", "Cpros")
                        loc_nEntradas = NVL(cursor_4c_Entradas.Total, 0)
                    ENDIF
                ENDIF

                *-- Saidas deste produto
                loc_nSaidas = 0
                IF USED("cursor_4c_Saidas")
                    SELECT cursor_4c_Saidas
                    IF SEEK(loc_cCPros, "cursor_4c_Saidas", "Cpros")
                        loc_nSaidas = NVL(cursor_4c_Saidas.Total, 0)
                    ENDIF
                ENDIF

                *-- Linhas de conta para este produto
                LOCAL loc_aEst(1,3)
                loc_nEstCount = 0
                loc_nTotalEst = 0

                IF USED("cursor_4c_EstContas")
                    SELECT cursor_4c_EstContas
                    LOCATE FOR Cpros = loc_cCPros
                    SCAN WHILE Cpros = loc_cCPros
                        loc_nEstCount = loc_nEstCount + 1
                        DIMENSION loc_aEst(loc_nEstCount, 3)
                        loc_aEst[loc_nEstCount, 1] = ALLTRIM(cursor_4c_EstContas.Grupos)
                        loc_aEst[loc_nEstCount, 2] = ALLTRIM(cursor_4c_EstContas.Estos)
                        loc_aEst[loc_nEstCount, 3] = NVL(cursor_4c_EstContas.Estoques, 0)
                        loc_nTotalEst = loc_nTotalEst + NVL(cursor_4c_EstContas.Estoques, 0)
                    ENDSCAN
                ENDIF

                *-- Diferenca = Entradas - Saidas - SomEstoques
                loc_nDif = loc_nEntradas - loc_nSaidas - loc_nTotalEst

                *-- Aplicar filtro optDiferencas
                DO CASE
                    CASE THIS.this_nDiferenca = 2
                        IF ABS(loc_nDif) > 0.001
                            LOOP
                        ENDIF
                    CASE THIS.this_nDiferenca = 3
                        IF loc_nDif <= 0.001
                            LOOP
                        ENDIF
                    CASE THIS.this_nDiferenca = 4
                        IF loc_nDif >= -0.001
                            LOOP
                        ENDIF
                ENDCASE

                *-- Linha header do produto (Ordem='0000000001')
                SELECT crImpressao
                INSERT INTO crImpressao (CPros, DPros, Reffs, CGrus, Linhas, IFors, ;
                    Ordem, Pvens, Moevs, Entradas, Saidas, Grupos, Margems) ;
                    VALUES (loc_cCPros, ;
                        PADR(ALLTRIM(cursor_4c_Prods.DPros), 40), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Reffs), 15), ;
                        PADR(ALLTRIM(cursor_4c_Prods.CGrus), 3), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Linhas), 10), ;
                        PADR(ALLTRIM(cursor_4c_Prods.IFors), 10), ;
                        "0000000001", ;
                        NVL(cursor_4c_Prods.Pvens, 0), ;
                        PADR(ALLTRIM(cursor_4c_Prods.Moevs), 3), ;
                        loc_nEntradas, loc_nSaidas, ;
                        PADR(ALLTRIM(cursor_4c_Prods.DGrus), 30), ;
                        NVL(cursor_4c_Prods.Margems, 0))

                *-- Linhas de conta (Ordem='0000000002', '0000000003', ...)
                loc_nOrdem = 2
                FOR loc_nEstLine = 1 TO loc_nEstCount
                    SELECT crImpressao
                    INSERT INTO crImpressao (CPros, Ordem, Estos, Estoques) ;
                        VALUES (loc_cCPros, ;
                            PADL(ALLTRIM(STR(loc_nOrdem)), 10, "0"), ;
                            PADR(loc_aEst[loc_nEstLine,1] + " " + ;
                                 loc_aEst[loc_nEstLine,2], 30), ;
                            loc_aEst[loc_nEstLine,3])
                    loc_nOrdem = loc_nOrdem + 1
                ENDFOR

                *-- Linha total (Estos='Total :   ')
                SELECT crImpressao
                INSERT INTO crImpressao (CPros, Ordem, Estos, Estoques, Diferencas) ;
                    VALUES (loc_cCPros, ;
                        "9999999999", ;
                        PADR("Total :   ", 30), ;
                        loc_nTotalEst, loc_nDif)

            ENDSCAN

            WAIT CLEAR

            SELECT crImpressao
            GO TOP

            loc_lSucesso = (RECCOUNT("crImpressao") > 0)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Nenhum dado encontrado para os filtros informados"
            ENDIF

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCursorExcel - Prepara cursor csExcell para exportacao
    * Analogo ao evento "documentoexcel" do legado.
    * Chama PrepararDados antes de montar o cursor de exportacao.
    *--------------------------------------------------------------------------
    PROCEDURE MontarCursorExcel()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF USED("csExcell")
                USE IN csExcell
            ENDIF

            IF THIS.this_nTipos = 1
                *-- Analitico: linha por produto/conta com IIF para suprimir valores nas linhas de conta
                SELECT IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.CPros), ;
                           SPACE(14)) AS Codigo, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.DPros), ;
                           SPACE(40)) AS Descricao, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.Reffs), ;
                           SPACE(15)) AS Referencia, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.CGrus), ;
                           SPACE(3)) AS Grp, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.Linhas), ;
                           SPACE(10)) AS Linha, ;
                       IIF(crImpressao.Ordem = "0000000001", ALLTRIM(crImpressao.IFors), ;
                           SPACE(10)) AS Fornecedor, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Margems, 0) AS Markup, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Entradas, 0) AS Entradas, ;
                       IIF(crImpressao.Ordem = "0000000001", crImpressao.Saidas, 0) AS Saidas, ;
                       IIF(crImpressao.Ordem = "0000000001", ;
                           crImpressao.Entradas - crImpressao.Saidas, 0) AS Saldo, ;
                       ALLTRIM(crImpressao.Grupos) AS Grupos, ;
                       ALLTRIM(crImpressao.Estos) AS Contas, ;
                       crImpressao.Estoques AS Qtde, ;
                       IIF(ALLTRIM(crImpressao.Estos) = "Total :   ", crImpressao.Diferencas, ;
                           0) AS Diferencas ;
                  FROM crImpressao ;
                  INTO CURSOR csExcell READWRITE
            ELSE
                *-- Sintetico: apenas linha header por produto
                SELECT ALLTRIM(crImpressao.CPros) AS Codigo, ;
                       ALLTRIM(crImpressao.DPros) AS Descricao, ;
                       ALLTRIM(crImpressao.Reffs) AS Referencia, ;
                       ALLTRIM(crImpressao.CGrus) AS Grp, ;
                       ALLTRIM(crImpressao.Linhas) AS Linha, ;
                       ALLTRIM(crImpressao.IFors) AS Fornecedor, ;
                       crImpressao.Margems AS Markup, ;
                       crImpressao.Entradas AS Entradas, ;
                       crImpressao.Saidas AS Saidas, ;
                       crImpressao.Entradas - crImpressao.Saidas AS Saldo, ;
                       crImpressao.Estoques AS Qtde, ;
                       crImpressao.Diferencas AS Diferencas ;
                  FROM crImpressao ;
                 WHERE crImpressao.Estos = PADR("Total :   ", 30) ;
                  INTO CURSOR csExcell READWRITE
            ENDIF

            SELECT csExcell
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao montar cursor Excel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
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
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX
        LOCAL loc_cCursorSel1, loc_cCursorSel2

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_lImagem
                *-- Com imagem: monta Selecao intermediaria
                THIS.MontarSelecaoComImagem()
                loc_cFRX = gc_4c_CaminhoReports + "SigReAtu"
                SELECT Selecao
                GO TOP
            ELSE
                SELECT crImpressao
                GO TOP
            ENDIF

            THIS.ExecutarReportForm("SigReAto", "PREVIEW", THIS.this_cCursorDados)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_lImagem
                THIS.MontarSelecaoComImagem()
                loc_cFRX = gc_4c_CaminhoReports + "SigReAtu"
                SELECT Selecao
                GO TOP
            ELSE
                loc_cFRX = gc_4c_CaminhoReports + "SigReAto"
                SELECT crImpressao
                GO TOP
            ENDIF

            REPORT FORM (loc_cFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSelecaoComImagem - Prepara cursor Selecao para SigReAtu.frx
    * Equivale ao bloco "If (optImagem.Value=1)" dos eventos impressao/visualizacao
    * do legado. Usa crImpressao (deve estar populado por PrepararDados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSelecaoComImagem()
        LOCAL loc_oErro
        TRY
            IF USED("Selecao1")
                USE IN Selecao1
            ENDIF
            IF USED("Selecao2")
                USE IN Selecao2
            ENDIF
            IF USED("Selecao")
                USE IN Selecao
            ENDIF

            SELECT CPros, DPros, Reffs, CGrus, Linhas, IFors, Ordem, Estos, ;
                   Imagem, Pvens, Moevs, Entradas, Saidas, Grupos, Margems ;
              FROM crImpressao ;
             WHERE Ordem = "0000000001" ;
              INTO CURSOR Selecao1

            SELECT CPros, SUM(Estoques) AS Estoques ;
              FROM crImpressao ;
             WHERE ALLTRIM(Estos) = "Total :   " ;
             GROUP BY CPros ;
              INTO CURSOR Selecao2

            SELECT a.*, b.Estoques ;
              FROM Selecao1 a, Selecao2 b ;
             WHERE a.CPros = b.CPros ;
             ORDER BY a.CPros ;
              INTO CURSOR Selecao READWRITE

            SELECT Selecao
            GO TOP
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em MontarSelecaoComImagem")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta de filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOC(THIS.this_dDtInicial) + "|" + DTOC(THIS.this_dDtFinal) + "|" + ;
               ALLTRIM(THIS.this_cGrupo) + "|" + ALLTRIM(THIS.this_cCPros) + "|" + ;
               ALLTRIM(THIS.this_cLin) + "|" + ALLTRIM(THIS.this_cFornecedor) + "|" + ;
               STR(THIS.this_nTipos, 1) + "|" + STR(THIS.this_nDiferenca, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta cursor para planilha Excel (XL5)
    *   Usa PUTFILE para escolha interativa do arquivo destino.
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lResultado, loc_cArquivo, loc_lSafetyEra
        loc_lResultado = .F.
        TRY
            IF THIS.MontarCursorExcel()
                loc_cArquivo = PUTFILE("Exportar para Excel", "AnEstTpOpe.xls", "xls")
                IF !EMPTY(loc_cArquivo)
                    IF LOWER(RIGHT(loc_cArquivo, 4)) != ".xls"
                        loc_cArquivo = loc_cArquivo + ".xls"
                    ENDIF
                    SELECT csExcell
                    loc_lSafetyEra = (SET("SAFETY") = "ON")
                    SET SAFETY OFF
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF loc_lSafetyEra
                        SET SAFETY ON
                    ENDIF
                    THIS.RegistrarAuditoria("EXCEL")
                    MsgInfo("Arquivo exportado com sucesso!", ;
                            "Informa" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao exportar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("csExcell")
            USE IN csExcell
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

ENDDEFINE
