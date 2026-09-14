*=============================================================================
* SigPrGmiBO.prg - Business Object: Geracao de Pedido de Estoque Minimo
* Herda de BusinessBase
*=============================================================================

DEFINE CLASS SigPrGmiBO AS BusinessBase

    *-- Filtros do formulario
    this_cEmpresa     = ""   && SigCdEmp.Cemps char(3)
    this_cDsEmpresa   = ""   && SigCdEmp.Razas char(40)
    this_cGrEstoque   = ""   && Grupo de Estoque - codigo char(10)
    this_cDsGrEstoque = ""   && Grupo de Estoque - descricao
    this_cEstoque     = ""   && Conta de Estoque - codigo char(10)
    this_cDsEstoque   = ""   && Conta de Estoque - descricao
    this_cLinha       = ""   && SigCdLin.linhas - codigo char(10)
    this_cDsLinha     = ""   && SigCdLin.descs - descricao char(40)
    this_cNegativo    = "N"  && S = somente saldos negativos
    this_dDatai       = {}   && Data de geracao do pedido
    this_cOperacao    = ""   && SigCdLin.pedidos - operacao associada a linha

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor crSigCdLin para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cLinha    = TratarNulo(linhas, "C")
                THIS.this_cDsLinha  = TratarNulo(descs, "C")
                THIS.this_cOperacao = TratarNulo(pedidos, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmpresa, 3) + PADR(THIS.this_cOperacao, 20) + SPACE(6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursorLinhas - Carrega cursor cursor_4c_SigCdLin para lookup
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCursorLinhas()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT descs, linhas, pedidos FROM SigCdLin ORDER BY descs, linhas, pedidos"
            IF USED("cursor_4c_SigCdLin")
                USE IN cursor_4c_SigCdLin
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdLin") > 0
                SELECT cursor_4c_SigCdLin
                INDEX ON DESCS TAG DESCS
                INDEX ON linhas TAG linhas
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar linhas de produ" + CHR(231) + CHR(227) + "o"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios do filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Empresa"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cGrEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar o Grupo de Estoque"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Conta de Estoque"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cLinha))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Linha de Produ" + CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatai)
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Data de Gera" + CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera pedidos de estoque minimo (acao principal do formulario)
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !THIS.ValidarDados()
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF
            loc_lResultado = THIS.ProcessarPedido()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar pedido")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPedido - Logica completa de geracao de pedidos de estoque minimo
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPedido()
        LOCAL loc_lResultado, loc_cSQL, loc_lTransacaoAberta
        LOCAL loc_cEmpresa, loc_cGrEstoque, loc_cEstoque, loc_cLinha, loc_cNegativo
        LOCAL loc_cOperacao, loc_cGruOrigs, loc_nOpers
        LOCAL loc_nNumero, loc_lnItens, loc_cFornece, loc_cEmpDopNums, loc_cMascNum
        LOCAL loc_cOpers, loc_nIncVal, loc_nTotalReg, loc_cChave
        LOCAL loc_loBarra
        LOCAL loc_cScanCPros, loc_cScanIFors, loc_nScanPVens
        LOCAL loc_cScanMoevs, loc_cScanDpros, loc_nScanQtds

        loc_lResultado       = .F.
        loc_lTransacaoAberta = .F.
        loc_loBarra          = .NULL.
        loc_nNumero          = 0
        loc_lnItens          = 0

        TRY
            *-- Copiar propriedades para vars locais
            loc_cEmpresa   = THIS.this_cEmpresa
            loc_cGrEstoque = THIS.this_cGrEstoque
            loc_cEstoque   = THIS.this_cEstoque
            loc_cLinha     = ALLTRIM(THIS.this_cLinha)
            loc_cNegativo  = THIS.this_cNegativo

            *-- Verificar se a linha possui operacao cadastrada
            loc_cSQL = "SELECT linhas, pedidos FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLinha)
            IF USED("cursor_4c_LinhaOpe")
                USE IN cursor_4c_LinhaOpe
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhaOpe") < 1 OR RECCOUNT("cursor_4c_LinhaOpe") = 0
                MsgAviso("Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o est" + CHR(225) + " cadastrada...", "Aten" + CHR(231) + CHR(227) + "o")
                IF USED("cursor_4c_LinhaOpe")
                    USE IN cursor_4c_LinhaOpe
                ENDIF
                loc_lResultado = .F.
            ENDIF
            SELECT cursor_4c_LinhaOpe
            IF EMPTY(ALLTRIM(pedidos))
                MsgAviso("Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o possui uma Opera" + CHR(231) + CHR(227) + "o cadastrada...", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN cursor_4c_LinhaOpe
                loc_lResultado = .F.
            ENDIF
            loc_cOperacao    = ALLTRIM(pedidos)
            THIS.this_cOperacao = loc_cOperacao
            USE IN cursor_4c_LinhaOpe

            *-- Branch: somente negativos ou abaixo do minimo
            IF ALLTRIM(loc_cNegativo) # "S"

                *-- Ramo 1: Produtos com saldo abaixo do estoque minimo
                loc_cSQL = "SELECT E.emps, E.grupos, E.estos, E.cpros, E.sqtds, " + ;
                    "P.linhas, P.situas, P.qmins, P.ifors, P.pvens, P.moevs, P.dpros " + ;
                    "FROM SigMvEst E " + ;
                    "JOIN SigCdPro P ON E.cpros = P.cpros " + ;
                    "WHERE E.emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.grupos = " + EscaparSQL(loc_cGrEstoque) + ;
                    " AND E.estos = " + EscaparSQL(loc_cEstoque) + ;
                    " AND E.sqtds < P.qmins" + ;
                    " AND P.linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.situas = 1 AND P.qmins > 0 " + ;
                    "ORDER BY E.emps, E.grupos, E.estos, E.cpros"
                IF USED("cursor_4c_Temp1")
                    USE IN cursor_4c_Temp1
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp1") < 1
                    MsgErro("Falha na consulta de estoques abaixo do m" + CHR(237) + "nimo", "Erro")
                    loc_lResultado = .F.
                ENDIF

                *-- Produtos que NAO tem registro em SigMvEst para esta empresa/grupo/conta
                loc_cChave = PADR(loc_cEmpresa, 3) + PADR(loc_cGrEstoque, 10) + PADR(loc_cEstoque, 10)
                loc_cSQL = "SELECT cpros, qmins, ifors, pvens, moevs, dpros " + ;
                    "FROM SigCdPro " + ;
                    "WHERE linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND qmins > 0 AND situas = 1 " + ;
                    "AND " + EscaparSQL(loc_cChave) + " + RTRIM(cpros) " + ;
                    "NOT IN (SELECT RTRIM(empgruests) + RTRIM(cpros) FROM SigMvEst)"
                IF USED("cursor_4c_Temp2")
                    USE IN cursor_4c_Temp2
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp2") < 1
                    MsgErro("Falha na consulta de produtos sem estoque cadastrado", "Erro")
                    IF USED("cursor_4c_Temp1")
                        USE IN cursor_4c_Temp1
                    ENDIF
                    loc_lResultado = .F.
                ENDIF

                *-- UNION ALL: abaixo do minimo + sem registro de estoque
                IF USED("TmpMinimo")
                    USE IN TmpMinimo
                ENDIF
                SET NULL ON
                SELECT m.loc_cEmpresa AS Emps, m.loc_cGrEstoque AS Grupos, ;
                       m.loc_cEstoque AS Estos, cpros, sqtds, qmins, ;
                       qmins - sqtds AS DifProds, ifors, pvens, moevs, dpros ;
                    FROM cursor_4c_Temp1 ;
                    WHERE emps = m.loc_cEmpresa AND grupos = m.loc_cGrEstoque ;
                    AND estos = m.loc_cEstoque ;
                    AND sqtds < qmins AND linhas = m.loc_cLinha ;
                    AND situas = 1 AND qmins > 0 ;
                UNION ALL ;
                SELECT m.loc_cEmpresa AS Emps, m.loc_cGrEstoque AS Grupos, ;
                       m.loc_cEstoque AS Estos, cpros, 0.000 AS sqtds, qmins, ;
                       qmins AS DifProds, ifors, pvens, moevs, dpros ;
                    FROM cursor_4c_Temp2 ;
                INTO CURSOR TmpMinimo READWRITE
                SET NULL OFF

                IF USED("cursor_4c_Temp1")
                    USE IN cursor_4c_Temp1
                ENDIF
                IF USED("cursor_4c_Temp2")
                    USE IN cursor_4c_Temp2
                ENDIF

            ELSE

                *-- Ramo 2: Somente produtos com saldo negativo
                loc_cSQL = "SELECT E.emps, E.grupos, E.estos, E.cpros, E.sqtds, " + ;
                    "P.ifors, P.situas, P.linhas, P.pvens, P.moevs, P.dpros " + ;
                    "FROM SigMvEst E " + ;
                    "JOIN SigCdPro P ON E.cpros = P.cpros " + ;
                    "WHERE E.emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.grupos = " + EscaparSQL(loc_cGrEstoque) + ;
                    " AND E.estos = " + EscaparSQL(loc_cEstoque) + ;
                    " AND E.sqtds < 0" + ;
                    " AND P.linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.situas = 1 " + ;
                    "ORDER BY E.emps, E.grupos, E.estos, E.cpros"
                IF USED("cursor_4c_Temp3")
                    USE IN cursor_4c_Temp3
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp3") < 1
                    MsgErro("Falha na consulta de estoques negativos", "Erro")
                    loc_lResultado = .F.
                ENDIF

                IF USED("TmpMinimo")
                    USE IN TmpMinimo
                ENDIF
                SET NULL ON
                SELECT m.loc_cEmpresa AS Emps, m.loc_cGrEstoque AS Grupos, ;
                       m.loc_cEstoque AS Estos, cpros, sqtds, 0 AS qmins, ;
                       ABS(sqtds) AS DifProds, ifors, pvens, moevs, dpros ;
                    FROM cursor_4c_Temp3 ;
                INTO CURSOR TmpMinimo READWRITE
                SET NULL OFF

                IF USED("cursor_4c_Temp3")
                    USE IN cursor_4c_Temp3
                ENDIF

            ENDIF

            *-- Verificar se ha produtos para processar
            SELECT TmpMinimo
            GO TOP
            IF EOF()
                MsgAviso("Nenhum produto selecionado...", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN TmpMinimo
                loc_lResultado = .F.
            ENDIF

            *-- Buscar pedidos em andamento para descontar do que precisa pedir
            loc_cSQL = "SELECT I.cpros, I.qtds, I.qtbxprods " + ;
                "FROM SigMvCab E " + ;
                "JOIN SigMvItn I ON E.empdopnums = I.empdopnums " + ;
                "JOIN SigCdOpe O ON E.dopes = O.dopes " + ;
                "WHERE E.emps = " + EscaparSQL(loc_cEmpresa) + ;
                " AND (O.globalizas = 1 OR O.globalizas = 2) " + ;
                " AND E.grupods = " + EscaparSQL(loc_cGrEstoque) + ;
                " AND E.contads = " + EscaparSQL(loc_cEstoque)
            IF USED("cursor_4c_Temp4")
                USE IN cursor_4c_Temp4
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp4")

            *-- Calcular total em producao por produto
            IF USED("TmpPedidos")
                USE IN TmpPedidos
            ENDIF
            IF USED("cursor_4c_Temp4") AND RECCOUNT("cursor_4c_Temp4") > 0
                SELECT cpros, SUM(qtds - qtbxprods) AS Produzindo ;
                    FROM cursor_4c_Temp4 ;
                    GROUP BY cpros ;
                    INTO CURSOR TmpPedidos READWRITE
            ELSE
                CREATE CURSOR TmpPedidos (cpros C(14), Produzindo N(11, 3))
            ENDIF
            IF USED("cursor_4c_Temp4")
                USE IN cursor_4c_Temp4
            ENDIF

            *-- Calcular quantidade a pedir: diferenca - ja em producao
            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF
            SELECT M.cpros, M.ifors, M.pvens, M.moevs, M.dpros, ;
                M.DifProds - IIF(ISNULL(P.Produzindo), 0, P.Produzindo) AS Qtds ;
                FROM TmpMinimo M ;
                LEFT JOIN TmpPedidos P ON M.cpros = P.cpros ;
                WHERE M.DifProds > IIF(ISNULL(P.Produzindo), 0, P.Produzindo) ;
                INTO CURSOR TmpProd READWRITE

            IF USED("TmpPedidos")
                USE IN TmpPedidos
            ENDIF
            IF USED("TmpMinimo")
                USE IN TmpMinimo
            ENDIF

            SELECT TmpProd
            GO TOP
            IF EOF()
                MsgAviso("Nenhum produto selecionado...", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN TmpProd
                loc_lResultado = .F.
            ENDIF

            *-- Ordenar por fornecedor + produto para agrupar por pedido
            INDEX ON ifors + cpros TAG ForProd
            COUNT TO loc_nTotalReg

            *-- Barra de progresso
            loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Pedidos...", loc_nTotalReg)
            loc_loBarra.Show()

            *-- Buscar dados da operacao (grupo de origem e tipo entrada/saida)
            loc_cSQL = "SELECT dopes, gruorigs, opers FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cOperacao)
            IF USED("cursor_4c_SigCdOpe")
                USE IN cursor_4c_SigCdOpe
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpe")
            SELECT cursor_4c_SigCdOpe
            GO TOP
            IF EOF()
                loc_cGruOrigs = "ESTOQUE"
                loc_nOpers    = 0
            ELSE
                loc_cGruOrigs = IIF(EMPTY(ALLTRIM(gruorigs)), "ESTOQUE", ALLTRIM(gruorigs))
                loc_nOpers    = IIF(VARTYPE(opers) = "N", NVL(opers, 0), IIF(ALLTRIM(TRANSFORM(opers)) = "1", 1, 0))
            ENDIF
            IF USED("cursor_4c_SigCdOpe")
                USE IN cursor_4c_SigCdOpe
            ENDIF

            *-- Iniciar transacao SQL Server
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacaoAberta = .T.

            *-- SCAN: gerar cabecalhos e itens de pedido agrupados por fornecedor
            loc_cFornece = REPL(CHR(255), 10)
            loc_nNumero  = 0
            loc_lnItens  = 0

            SELECT TmpProd
            SCAN
                loc_loBarra.Update(.T.)

                *-- Capturar campos do registro corrente antes de SQLEXEC
                loc_cScanCPros  = ALLTRIM(TmpProd.cpros)
                loc_cScanIFors  = ALLTRIM(TmpProd.ifors)
                loc_nScanPVens  = TmpProd.pvens
                loc_cScanMoevs  = ALLTRIM(TmpProd.moevs)
                loc_cScanDpros  = LEFT(ALLTRIM(TmpProd.dpros), 65)
                loc_nScanQtds   = TmpProd.Qtds

                IF loc_cFornece # loc_cScanIFors
                    *-- Novo fornecedor: gerar numero e inserir cabecalho SigMvCab
                    loc_nNumero     = fGerUniqueKey(ALLTRIM(loc_cOperacao) + loc_cEmpresa)
                    loc_cFornece    = loc_cScanIFors
                    loc_cEmpDopNums = loc_cEmpresa + PADR(loc_cOperacao, 20) + STR(loc_nNumero, 6)
                    loc_cMascNum    = ALLTRIM(fGerMascara(loc_nNumero))

                    loc_cSQL = "INSERT INTO SigMvCab " + ;
                        "(emps, dopes, numes, datas, datars, mascnum, " + ;
                        " grupoos, contaos, grupods, contads, usuars, empdopnums, cidchaves, dtalts) " + ;
                        "VALUES (" + ;
                        EscaparSQL(loc_cEmpresa) + ", " + ;
                        EscaparSQL(PADR(loc_cOperacao, 20)) + ", " + ;
                        FormatarNumeroSQL(loc_nNumero, 0) + ", " + ;
                        FormatarDataSQL(THIS.this_dDatai) + ", " + ;
                        FormatarDataSQL(THIS.this_dDatai) + ", " + ;
                        EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cGruOrigs, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cFornece, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cGrEstoque, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cEstoque, 10)) + ", " + ;
                        EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                        EscaparSQL(loc_cEmpDopNums) + ", " + ;
                        EscaparSQL(fUniqueIds()) + ", " + ;
                        "GETDATE())"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Falha ao inserir cabe" + CHR(231) + "alho do pedido (SigMvCab)", "Erro")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAberta = .F.
                        loc_loBarra.Complete(.T.)
                        IF USED("TmpProd")
                            USE IN TmpProd
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF
                    loc_lnItens = 0
                ENDIF

                *-- Inserir item do pedido (SigMvItn)
                loc_lnItens  = loc_lnItens + 1
                loc_cOpers   = IIF(loc_nOpers = 1, "E", "S")
                loc_nIncVal  = loc_nScanPVens * loc_nScanQtds

                loc_cSQL = "INSERT INTO SigMvItn " + ;
                    "(emps, dopes, numes, citens, cpros, qtds, units, moedas, opers, totas, dpros, empdopnums, cidchaves, dtalts) " + ;
                    "VALUES (" + ;
                    EscaparSQL(loc_cEmpresa) + ", " + ;
                    EscaparSQL(PADR(loc_cOperacao, 20)) + ", " + ;
                    FormatarNumeroSQL(loc_nNumero, 0) + ", " + ;
                    FormatarNumeroSQL(loc_lnItens, 0) + ", " + ;
                    EscaparSQL(loc_cScanCPros) + ", " + ;
                    FormatarNumeroSQL(loc_nScanQtds, 3) + ", " + ;
                    FormatarNumeroSQL(loc_nScanPVens, 5) + ", " + ;
                    EscaparSQL(LEFT(loc_cScanMoevs, 3)) + ", " + ;
                    EscaparSQL(loc_cOpers) + ", " + ;
                    FormatarNumeroSQL(loc_nIncVal, 2) + ", " + ;
                    EscaparSQL(loc_cScanDpros) + ", " + ;
                    EscaparSQL(loc_cEmpDopNums) + ", " + ;
                    EscaparSQL(fUniqueIds()) + ", " + ;
                    "GETDATE())"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao inserir item do pedido (SigMvItn)", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAberta = .F.
                    loc_loBarra.Complete(.T.)
                    IF USED("TmpProd")
                        USE IN TmpProd
                    ENDIF
                    loc_lResultado = .F.
                ENDIF

                *-- Atualizar totais do cabecalho
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                    "valinis = valinis + " + FormatarNumeroSQL(loc_nIncVal, 2) + ", " + ;
                    "valos = valos + " + FormatarNumeroSQL(loc_nIncVal, 2) + ", " + ;
                    "dtalts = GETDATE() " + ;
                    "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
                SQLEXEC(gnConnHandle, loc_cSQL)

                SELECT TmpProd
            ENDSCAN

            *-- Confirmar transacao
            IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") < 1
                MsgErro("Falha ao confirmar a transa" + CHR(231) + CHR(227) + "o", "Erro")
                loc_lTransacaoAberta = .F.
                loc_loBarra.Complete(.T.)
                IF USED("TmpProd")
                    USE IN TmpProd
                ENDIF
                loc_lResultado = .F.
            ENDIF
            loc_lTransacaoAberta = .F.

            loc_loBarra.Complete(.T.)

            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF

            THIS.RegistrarAuditoria("PEDIDO_ESTOQUE_MINIMO")
            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            IF VARTYPE(loc_loBarra) = "O"
                loc_loBarra.Complete(.T.)
            ENDIF
            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF
            IF USED("TmpMinimo")
                USE IN TmpMinimo
            ENDIF
            IF USED("TmpPedidos")
                USE IN TmpPedidos
            ENDIF
            IF USED("cursor_4c_Temp1")
                USE IN cursor_4c_Temp1
            ENDIF
            IF USED("cursor_4c_Temp2")
                USE IN cursor_4c_Temp2
            ENDIF
            IF USED("cursor_4c_Temp3")
                USE IN cursor_4c_Temp3
            ENDIF
            IF USED("cursor_4c_Temp4")
                USE IN cursor_4c_Temp4
            ENDIF
            IF USED("cursor_4c_LinhaOpe")
                USE IN cursor_4c_LinhaOpe
            ENDIF
            IF USED("cursor_4c_SigCdOpe")
                USE IN cursor_4c_SigCdOpe
            ENDIF
            MsgErro(loc_oErro.Message, "Erro no processamento")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + ;
                EscaparSQL("SigMvCab") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe o fluxo principal
        ENDTRY
    ENDPROC

ENDDEFINE
