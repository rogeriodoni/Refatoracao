*==============================================================================
* SIGREEGGBO.PRG
* BO do Relatorio: Posicao de Estoque por Grande Grupo
*
* Herda de: RelatorioBase
* Origem: SIGREEGG.SCX (frmrelatorio)
* Relatorio FRX: SigReEgg.frx
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Grupo de Estoque (codigo + descricao via fAcessoContab)
*   - Conta de Estoque (codigo + descricao via fAcessoContas)
*   - Grande Grupo (codigo + descricao via SigCdGpr)
*   - Data de Posicao (data unica)
*   - Opcao de Custo (1=Sim / 2=Nao, default=2)
*   - Moeda (codigo + descricao via SigCdMoe)
*
* Cursores de referencia carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas)
*
* Cursor de resultado produzido por PrepararDados():
*   CsRelatorio - dados agrupados para REPORT FORM SigReEgg
*
* Cursor de cabecalho produzido por GerarCabecalho():
*   CsCabecalho - nomeempresa, titulo1, titulo2, periodo, impetiq, Impcusto
*==============================================================================

DEFINE CLASS SIGREEGGBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""
    this_cCdGGrupo      = ""
    this_cDsGGrupo      = ""
    this_dDataPos       = {}
    this_nOptCusto      = 2
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Nome do cursor de resultado
    this_cCursorDados   = "CsRelatorio"

    *--------------------------------------------------------------------------
    * Init - Configura BO e carrega cursor de empresas para processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_dDataPos    = DATE()
            THIS.this_nOptCusto   = 2
            THIS.this_cTabela     = "SigMvEst"
            THIS.this_cCampoChave = ""

            *-- Carregar empresas (usadas em Processar/ProcessarEmpresa)
            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF USED("cursor_4c_SigCdEmp")
                    USE IN cursor_4c_SigCdEmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cemps, razas, ativas FROM SigCdEmp", ;
                    "cursor_4c_SigCdEmp")

                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdEmp
                    INDEX ON cemps TAG cemps
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar cadastro de empresas"
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREEGGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra toda a preparacao do relatorio:
    *   1. Valida filtros
    *   2. Gera cabecalho
    *   3. Processa dados por empresa
    * Equivalente aos metodos processamento + processa do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.GerarCabecalho()
                    loc_lSucesso = .F.
                ELSE
                    IF !THIS.Processar()
                        loc_lSucesso = .F.
                    ELSE
                        IF USED(THIS.this_cCursorDados)
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                        ENDIF
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de processar
    * Equivalente as validacoes em btnReport.Click do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nCount

        loc_lSucesso = .F.
        TRY
            *-- Validar data de posicao (obrigatoria)
            IF EMPTY(THIS.this_dDataPos)
                THIS.this_cMensagemErro = "Data inv" + CHR(225) + "lida!"
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = .T.
            ENDIF

            *-- Validar Grupo de Estoque (se preenchido)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGcr" + ;
                    " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValGrEst
                    loc_nCount = NVL(cursor_4c_ValGrEst.nExiste, 0)
                    USE IN cursor_4c_ValGrEst
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Grupo de Estoque Inv" + ;
                            CHR(225) + "lido."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValGrEst
                ENDIF
            ENDIF

            *-- Validar Conta de Estoque (se preenchida)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli" + ;
                    " WHERE iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEstoque))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValEst
                    loc_nCount = NVL(cursor_4c_ValEst.nExiste, 0)
                    USE IN cursor_4c_ValEst
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Conta de Estoque Inv" + ;
                            CHR(225) + "lida."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValEst
                ENDIF
            ENDIF

            *-- Validar Grande Grupo (se preenchido)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdGGrupo))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGpr" + ;
                    " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGGrupo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGGrp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValGGrp
                    loc_nCount = NVL(cursor_4c_ValGGrp.nExiste, 0)
                    USE IN cursor_4c_ValGGrp
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Grande Grupo Inv" + ;
                            CHR(225) + "lido."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValGGrp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarFiltros")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCabecalho - Cria cursor CsCabecalho para o relatorio FRX.
    * Equivalente ao bloco inicial de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarCabecalho()
        LOCAL loc_lSucesso, loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2
        LOCAL loc_cPeriodo, loc_llImpEtiq, loc_llImpCusto
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrp
        LOCAL loc_ldDataPos

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo    = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cEstoque  = ALLTRIM(THIS.this_cCdEstoque)
            loc_cGGrp     = ALLTRIM(THIS.this_cCdGGrupo)
            loc_ldDataPos = THIS.this_dDataPos

            *-- Nome da empresa logada
            loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(go_4c_Sistema.cCodEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                        " - " + ALLTRIM(cursor_4c_SigCdEmp.razas)
                ENDIF
            ENDIF

            *-- Titulos do relatorio
            loc_cTitulo1 = "Posi" + CHR(231) + CHR(227) + "o de Estoque por Grande Grupo"

            loc_cTitulo2 = "Grupo: " + IIF(EMPTY(loc_cGrupo), "Todos", ;
                loc_cGrupo + " - " + ALLTRIM(THIS.this_cDsGrEstoque)) + ;
                " / Estoque: " + IIF(EMPTY(loc_cEstoque), "Todos", ;
                loc_cEstoque + " - " + ALLTRIM(THIS.this_cDsEstoque)) + ;
                " / Grande Grupo: " + IIF(EMPTY(loc_cGGrp), "Todos", loc_cGGrp)

            loc_cPeriodo   = "Estoque Existente em " + DTOC(loc_ldDataPos)
            loc_llImpEtiq  = (loc_ldDataPos = DATE())
            loc_llImpCusto = (THIS.this_nOptCusto = 1)

            *-- Criar cursor CsCabecalho
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF

            CREATE CURSOR CsCabecalho ;
                (nomeempresa C(80), titulo1 C(80), titulo2 C(150), ;
                 periodo C(80), impetiq L, Impcusto L)

            INSERT INTO CsCabecalho (nomeempresa, titulo1, titulo2, periodo, impetiq, Impcusto) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2, ;
                        loc_cPeriodo, loc_llImpEtiq, loc_llImpCusto)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Orquestra o processamento por empresa.
    * Se empresa vazia: itera todas as empresas ativas de cursor_4c_SigCdEmp.
    * Se empresa especificada: processa apenas ela.
    * Acumula resultados em CsRelatorio.
    * Equivalente ao corpo de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_llInicio, loc_llProcessa
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrp, loc_cCodEmp

        loc_lSucesso = .F.
        loc_llInicio = .T.

        TRY
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cEstoque = ALLTRIM(THIS.this_cCdEstoque)
            loc_cGGrp    = ALLTRIM(THIS.this_cCdGGrupo)

            *-- Fechar cursor de relatorio anterior
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            IF EMPTY(loc_cEmpresa)
                *-- Processar todas as empresas ativas (exceto 999 e ESC)
                IF !USED("cursor_4c_SigCdEmp")
                    THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                    loc_lSucesso = .F.
                ENDIF
                SELECT cursor_4c_SigCdEmp
                GO TOP
                SCAN
                    loc_cCodEmp = ALLTRIM(cursor_4c_SigCdEmp.cemps)
                    IF cursor_4c_SigCdEmp.ativas = 1 ;
                            AND loc_cCodEmp <> "999" ;
                            AND loc_cCodEmp <> "ESC"
                        loc_llProcessa = THIS.ProcessarEmpresa(loc_cCodEmp, ;
                            loc_cGrupo, loc_cEstoque, loc_cGGrp)
                        IF !loc_llProcessa
                            loc_lSucesso = .F.
                        ENDIF
                        IF loc_llInicio
                            SELECT * FROM CsRel INTO CURSOR CsRelatorio READWRITE
                            loc_llInicio = .F.
                        ELSE
                            SELECT CsRel
                            GO TOP
                            SCAN
                                SCATTER MEMO MEMVAR
                                INSERT INTO CsRelatorio FROM MEMVAR
                                SELECT CsRel
                            ENDSCAN
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_SigCdEmp
                ENDSCAN
            ELSE
                *-- Processar empresa unica
                loc_llProcessa = THIS.ProcessarEmpresa(loc_cEmpresa, ;
                    loc_cGrupo, loc_cEstoque, loc_cGGrp)
                IF !loc_llProcessa
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM CsRel INTO CURSOR CsRelatorio READWRITE
            ENDIF

            IF USED("CsRelatorio")
                SELECT CsRelatorio
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Processar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEmpresa - Executa as queries de estoque/etiquetas para uma empresa,
    * constroi os cursores intermediarios e gera o cursor CsRel agrupado.
    * Equivalente a PROCEDURE processa do legado SIGREEGG.
    *
    * Parametros:
    *   par_cEmpEst  - Codigo da empresa (3 chars)
    *   par_cGruEst  - Grupo de estoque (10 chars, pode ser vazio)
    *   par_cEstEst  - Conta de estoque (10 chars, pode ser vazio)
    *   par_cGGrupo  - Grande grupo (3 chars, pode ser vazio)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarEmpresa(par_cEmpEst, par_cGruEst, par_cEstEst, par_cGGrupo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpIni, loc_cEmpFin, loc_cGruIni, loc_cGruFin, loc_cEstIni, loc_cEstFin
        LOCAL loc_cFiltro, loc_cFilEti, loc_cDataPosSQL
        LOCAL loc_ldDataPos, loc_lnCotCus, loc_lnSQtds, loc_lnCot, loc_lnCus
        LOCAL loc_cEGEs, loc_cSQLHis

        loc_lSucesso  = .F.
        loc_ldDataPos = THIS.this_dDataPos

        TRY
            *-- Formatar data/hora SQL: 'YYYY-MM-DD 23:59:59'
            loc_cDataPosSQL = "'" + ;
                PADL(YEAR(loc_ldDataPos),  4, "0") + "-" + ;
                PADL(MONTH(loc_ldDataPos), 2, "0") + "-" + ;
                PADL(DAY(loc_ldDataPos),   2, "0") + " 23:59:59'"

            *-- Cotacao da moeda selecionada na data de posicao
            loc_lnCotCus = 1
            IF !EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                loc_lnCotCus = fBuscarCotacao(ALLTRIM(THIS.this_cCdMoeda), ;
                    loc_ldDataPos, gnConnHandle)
                IF loc_lnCotCus = 0
                    loc_lnCotCus = 1
                ENDIF
            ENDIF

            *-- Faixas de filtro (PADR garante comprimento fixo para BETWEEN/=)
            loc_cEmpIni = IIF(!EMPTY(ALLTRIM(par_cEmpEst)), ;
                PADR(ALLTRIM(par_cEmpEst), 3), SPACE(3))
            loc_cEmpFin = IIF(!EMPTY(ALLTRIM(par_cEmpEst)), ;
                PADR(ALLTRIM(par_cEmpEst), 3), REPLICATE(CHR(254), 3))
            loc_cGruIni = IIF(!EMPTY(ALLTRIM(par_cGruEst)), ;
                PADR(ALLTRIM(par_cGruEst), 10), SPACE(10))
            loc_cGruFin = IIF(!EMPTY(ALLTRIM(par_cGruEst)), ;
                PADR(ALLTRIM(par_cGruEst), 10), REPLICATE(CHR(254), 10))
            loc_cEstIni = IIF(!EMPTY(ALLTRIM(par_cEstEst)), ;
                PADR(ALLTRIM(par_cEstEst), 10), SPACE(10))
            loc_cEstFin = IIF(!EMPTY(ALLTRIM(par_cEstEst)), ;
                PADR(ALLTRIM(par_cEstEst), 10), REPLICATE(CHR(254), 10))

            *-- Filtro principal: empgruests = emp(3) + grupos(10) + estos(10)
            IF !EMPTY(ALLTRIM(par_cEmpEst)) AND ;
               !EMPTY(ALLTRIM(par_cGruEst)) AND ;
               !EMPTY(ALLTRIM(par_cEstEst))
                loc_cFiltro = "a.empgruests = '" + ;
                    PADR(ALLTRIM(par_cEmpEst), 3) + ;
                    PADR(ALLTRIM(par_cGruEst), 10) + ;
                    PADR(ALLTRIM(par_cEstEst), 10) + "'"
            ELSE
                loc_cFiltro = "a.empgruests BETWEEN '" + ;
                    loc_cEmpIni + loc_cGruIni + loc_cEstIni + ;
                    "' AND '" + ;
                    loc_cEmpFin + loc_cGruFin + loc_cEstFin + "'"
            ENDIF

            *-- Filtro etiquetas: usa colunas separadas (empos, grupos, contas)
            loc_cFilEti = "a.empos BETWEEN '" + ;
                    loc_cEmpIni + "' AND '" + loc_cEmpFin + "'" + ;
                " AND a.grupos BETWEEN '" + ;
                    loc_cGruIni + "' AND '" + loc_cGruFin + "'" + ;
                " AND a.contas BETWEEN '" + ;
                    loc_cEstIni + "' AND '" + loc_cEstFin + "'"
            IF loc_ldDataPos <> DATE()
                loc_cFilEti = loc_cFilEti + " AND a.datas <= " + loc_cDataPosSQL
            ENDIF

            *-- Fechar cursor temporario anterior
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF

            *-- Query principal: SigMvEst com joins SigCdPro, SigCdGrp, SigCdGpr
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.grupos, a.estos, a.cpros," + ;
                " a.sqtds AS saldo," + ;
                " c.mercs AS ggrupo, b.CustoFs, b.MoeCusFs, b.cUnis, d.Descs" + ;
                " FROM SigMvEst a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " INNER JOIN SigCdGrp c ON c.cgrus = b.cgrus" + ;
                " LEFT JOIN SigCdGpr d ON d.Codigos = c.Mercs" + ;
                " WHERE " + loc_cFiltro
            IF !EMPTY(ALLTRIM(par_cGGrupo))
                loc_cSQL = loc_cSQL + ;
                    " AND c.mercs = '" + ALLTRIM(par_cGGrupo) + "'"
            ENDIF
            loc_cSQL = loc_cSQL + ;
                " GROUP BY a.cidchaves, a.emps, a.grupos, a.estos, a.cpros," + ;
                " a.sqtds, c.mercs, b.CustoFs, b.MoeCusFs, d.Descs, b.cUnis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEst")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao selecionar produtos do estoque"
                loc_lSucesso = .F.
            ENDIF

            *-- Se data diferente de hoje: recalcular saldo historico a partir de SigMvHst
            IF loc_ldDataPos <> DATE()
                SELECT TmpEst
                GO TOP
                SCAN
                    IF EMPTY(TmpEst.emps) OR EMPTY(TmpEst.grupos) OR EMPTY(TmpEst.estos)
                        DELETE
                        LOOP
                    ENDIF

                    loc_lnSQtds = 0

                    *-- Chave composta: emps(3) + grupos(10) + estos(10) = 23 chars
                    loc_cEGEs = PADR(ALLTRIM(TmpEst.emps), 3) + ;
                        PADR(ALLTRIM(TmpEst.grupos), 10) + ;
                        PADR(ALLTRIM(TmpEst.estos), 10)

                    IF USED("TmpHis")
                        USE IN TmpHis
                    ENDIF

                    loc_cSQLHis = "SELECT TOP 1 EmpGruEsts, Cpros, CidChaves, Sqtds" + ;
                        " FROM SigMvHst" + ;
                        " WHERE EmpGruEsts = " + EscaparSQL(loc_cEGEs) + ;
                        " AND CPros = " + EscaparSQL(ALLTRIM(TmpEst.cpros)) + ;
                        " AND Datas <= " + loc_cDataPosSQL + ;
                        " ORDER BY EmpGruEsts ASC, Cpros ASC, CidChaves DESC"

                    IF SQLEXEC(gnConnHandle, loc_cSQLHis, "TmpHis") >= 1
                        SELECT TmpHis
                        GO TOP
                        IF !EOF()
                            loc_lnSQtds = TmpHis.SQtds
                        ENDIF
                    ENDIF

                    SELECT TmpEst
                    REPLACE TmpEst.saldo WITH loc_lnSQtds
                ENDSCAN

                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
            ENDIF

            *-- Agrupar TmpEst -> CsEst
            IF USED("CsEst")
                USE IN CsEst
            ENDIF

            SELECT MAX(emps) AS emps, grupos, estos, ggrupo, ;
                PADR(NVL(Descs, ""), 40) AS descs, MoeCusFs, cUnis, ;
                SUM(saldo) AS saldo, SUM(0.000) AS etiqs, ;
                SUM(CustoFs * saldo) AS CustoFs ;
                FROM TmpEst ;
                GROUP BY 2, 3, 4, 5, 6, 7 ;
                INTO CURSOR CsEst READWRITE

            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF

            *-- Se data = hoje: buscar etiquetas de SigOpEtq
            IF loc_ldDataPos = DATE()
                IF USED("TmpEti")
                    USE IN TmpEti
                ENDIF

                loc_cSQL = "SELECT a.cbars, a.empos, a.grupos, a.contas, a.cpros," + ;
                    " a.qtds AS etiqs, c.mercs AS ggrupo," + ;
                    " d.Descs, b.CustoFs, b.MoeCusFs, b.cUnis" + ;
                    " FROM SigOpEtq a" + ;
                    " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                    " INNER JOIN SigCdGrp c ON c.cgrus = b.cgrus" + ;
                    " LEFT JOIN SigCdGpr d ON d.Codigos = c.Mercs" + ;
                    " WHERE " + loc_cFilEti
                IF !EMPTY(ALLTRIM(par_cGGrupo))
                    loc_cSQL = loc_cSQL + ;
                        " AND c.mercs = '" + ALLTRIM(par_cGGrupo) + "'"
                ENDIF
                loc_cSQL = loc_cSQL + ;
                    " GROUP BY a.cbars, a.empos, a.grupos, a.contas, a.cpros," + ;
                    " a.qtds, c.mercs, d.Descs, b.CustoFs, b.MoeCusFs, b.cUnis"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEti")

                IF loc_nResult >= 1
                    IF USED("CsEti")
                        USE IN CsEti
                    ENDIF
                    SELECT MAX(empos) AS emps, grupos, contas AS estos, ggrupo, ;
                        PADR(NVL(Descs, ""), 40) AS descs, MoeCusFs, cUnis, ;
                        SUM(0.000) AS saldo, SUM(etiqs) AS etiqs, ;
                        SUM(0.000) AS CustoFs ;
                        FROM TmpEti ;
                        WHERE !EMPTY(grupos) AND !EMPTY(contas) ;
                        GROUP BY 2, 3, 4, 5, 6, 7 ;
                        INTO CURSOR CsEti READWRITE
                ENDIF

                IF USED("TmpEti")
                    USE IN TmpEti
                ENDIF
            ENDIF

            *-- Montar TmpRelatorio: UNION ALL CsEst + CsEti (ou apenas CsEst)
            IF USED("TmpRelatorio")
                USE IN TmpRelatorio
            ENDIF

            IF loc_ldDataPos = DATE() AND USED("CsEti")
                SELECT * FROM CsEst ;
                UNION ALL ;
                SELECT * FROM CsEti ;
                INTO CURSOR TmpRelatorio READWRITE
            ELSE
                SELECT * FROM CsEst INTO CURSOR TmpRelatorio READWRITE
            ENDIF

            IF USED("CsEst")
                USE IN CsEst
            ENDIF
            IF USED("CsEti")
                USE IN CsEti
            ENDIF

            *-- Converter custo para moeda selecionada (se opt_custo = 1)
            IF THIS.this_nOptCusto = 1 AND !EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                SELECT TmpRelatorio
                SCAN
                    loc_lnCot = fBuscarCotacao(ALLTRIM(TmpRelatorio.MoeCusFs), ;
                        loc_ldDataPos, gnConnHandle)
                    IF loc_lnCot = 0
                        loc_lnCot = 1
                    ENDIF
                    loc_lnCus = TmpRelatorio.CustoFs * loc_lnCot / loc_lnCotCus
                    REPLACE TmpRelatorio.CustoFs WITH loc_lnCus, ;
                            TmpRelatorio.MoeCusFs WITH PADR(ALLTRIM(THIS.this_cCdMoeda), 3)
                ENDSCAN
            ENDIF

            *-- UNION ALL final com 3 tipos: detalhe(1), total grupo(2), total empresa(3)
            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            IF THIS.this_nOptCusto = 1
                SELECT 1 AS Tps, Emps, Grupos, Estos, GGrupo, ;
                        Grupos AS GrupoI, Estos AS EstoI, GGrupo AS GGrupoI, ;
                        cUnis, Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 2 AS Tps, Emps, Grupos, SPACE(10) AS Estos, ;
                        "   " AS GGrupo, SPACE(10) AS GrupoI, ;
                        SPACE(10) AS EstoI, "   " AS GGrupoI, ;
                        cUnis, PADR("Total Grupo", 40) AS Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 3 AS Tps, Emps, REPLICATE(CHR(254), 10) AS Grupos, ;
                        SPACE(10) AS Estos, "   " AS GGrupo, ;
                        SPACE(10) AS GrupoI, SPACE(10) AS EstoI, ;
                        "   " AS GGrupoI, cUnis, ;
                        PADR("Total Empresa", 40) AS Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                    INTO CURSOR CsRel ORDER BY 2, 3, 1, 5, 9, 11 READWRITE
            ELSE
                SELECT 1 AS Tps, Emps, Grupos, Estos, GGrupo, ;
                        Grupos AS GrupoI, Estos AS EstoI, GGrupo AS GGrupoI, ;
                        cUnis, Descs, " " AS MoeCusFs, 0 AS CustoFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 2 AS Tps, Emps, Grupos, SPACE(10) AS Estos, ;
                        "   " AS GGrupo, SPACE(10) AS GrupoI, ;
                        SPACE(10) AS EstoI, "   " AS GGrupoI, ;
                        cUnis, PADR("Total Grupo", 40) AS Descs, " " AS MoeCusFs, ;
                        0 AS CustoFS, SUM(Saldo) AS Saldo, ;
                        SUM(Etiqs) AS Etiqs, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 3 AS Tps, Emps, REPLICATE(CHR(254), 10) AS Grupos, ;
                        SPACE(10) AS Estos, "   " AS GGrupo, ;
                        SPACE(10) AS GrupoI, SPACE(10) AS EstoI, ;
                        "   " AS GGrupoI, cUnis, ;
                        PADR("Total Empresa", 40) AS Descs, " " AS MoeCusFs, ;
                        0 AS CustoFS, SUM(Saldo) AS Saldo, ;
                        SUM(Etiqs) AS Etiqs, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                    INTO CURSOR CsRel ORDER BY 2, 3, 1, 5, 9, 11 READWRITE
            ENDIF

            IF USED("TmpRelatorio")
                USE IN TmpRelatorio
            ENDIF

            *-- Remover linhas com saldo = 0 (e etiqs = 0 se for hoje)
            IF loc_ldDataPos = DATE()
                DELETE FROM CsRel WHERE saldo = 0 AND etiqs = 0
            ELSE
                DELETE FROM CsRel WHERE saldo = 0
            ENDIF

            *-- Marcar ImpLinha: linha anterior a cada "Total ..." recebe .T.
            SELECT CsRel
            GO TOP
            LOCAL loc_nVz, loc_cDescAtual
            loc_nVz = 1
            DO WHILE !EOF()
                IF loc_nVz = 1
                    LOCATE FOR Descs = "Total "
                ELSE
                    CONTINUE
                ENDIF
                IF !EOF()
                    SKIP -1
                    IF !DELETED()
                        REPLACE ImpLinha WITH .T.
                    ENDIF
                    SKIP
                    loc_cDescAtual = Descs
                    DO WHILE Descs = loc_cDescAtual AND !EOF()
                        SKIP
                    ENDDO
                    IF !EOF()
                        SKIP -1
                    ENDIF
                ENDIF
                loc_nVz = 2
            ENDDO

            SELECT CsRel
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ProcessarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela.
    * Equivalente a PROCEDURE visualizacao do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEgg"
                REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora com prompt.
    * Equivalente a PROCEDURE impressao do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEgg"
                REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios.
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios.
    * Relatorios sao somente-leitura. Use Imprimir() ou Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios.
    * Relatorios sao somente-leitura. Use Imprimir() ou Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresIntermedios - Fecha todos os cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresIntermedios()
        LOCAL loc_aCursores[8], loc_i

        loc_aCursores[1] = "TmpEst"
        loc_aCursores[2] = "TmpEti"
        loc_aCursores[3] = "TmpHis"
        loc_aCursores[4] = "TmpRelatorio"
        loc_aCursores[5] = "CsEst"
        loc_aCursores[6] = "CsEti"
        loc_aCursores[7] = "CsRel"
        loc_aCursores[8] = "CsCabecalho"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia e intermediarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursoresIntermedios()

        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
