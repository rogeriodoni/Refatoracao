*==============================================================================
* SIGRECTCBO.PRG
* Business Object para Relatorio Movimentacao de Cartoes
* Herda de RelatorioBase
* Formulario original: SIGRECTC (sigrectc.SCX)
*==============================================================================

DEFINE CLASS sigrectcBO AS RelatorioBase

    *-- Arquivo e titulo do relatorio
    this_cArquivoRelatorio  = ""
    this_cTituloRelatorio   = ""

    *-- Cursor de saida do relatorio (UNION ALL de listpro1-4)
    this_cCursorDados       = "cursor_4c_DadosCtc"

    *-- Filtros de periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro de empresa (get_cemps + get_razas)
    this_cEmps              = ""
    this_cRazas             = ""

    *-- Filtro de cartao/forma de pagamento (get_fpags)
    this_cFpags             = ""

    *-- Checkboxes de tipo de movimentacao (0=desmarcado, 1=marcado)
    this_lEntrada           = .F.
    this_lReceber           = .F.
    this_lDepositar         = .F.
    this_lBaixa             = .F.

    *-- OptTpDep: 1=Entrada, 2=Vencimento (controla logica de deposito)
    this_nOptTpDep          = 1

    *-- Deposito por vencimento previsto: Option2 habilitado e TpDep = 2
    this_lDepPrev           = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de movimentacao de cartoes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "relsigrectc.frx"
            THIS.this_cTituloRelatorio  = "Relat" + CHR(243) + "rio Movimenta" + ;
                                          CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es"
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCartoes - Carrega cursor de cartoes para lookup do campo fpags
    * SQL original: Select dcarts From SigOpFp where Infos = 'T' group by dcarts
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCartoes()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Cartoes")
                USE IN cursor_4c_Cartoes
            ENDIF
            loc_cSQL = "SELECT dcarts FROM SigOpFp WHERE Infos = 'T' GROUP BY dcarts"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cartoes")
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Imposs" + CHR(237) + "vel carregar cart" + CHR(245) + "es"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores consolidados para o relatorio.
    * Processa 4 tipos de movimento: Entradas, A Receber, A Depositar, Baixados.
    * Baseado no PROCEDURE processamento do SIGRECTC.SCX original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_lAbortou
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cNomeEmpresa
        LOCAL loc_cEmpresaWhereA, loc_cEmpresaWhereB, loc_cEmpresaWhereD
        LOCAL loc_cCartaoWhereB, loc_cCartaoWhereD
        LOCAL loc_nOpMovimento, loc_cMovimento
        LOCAL loc_dDtIni, loc_dDtFim
        LOCAL loc_cDtIniSQL, loc_cDtFimSQL
        LOCAL loc_cCursorNome

        loc_lSucesso    = .F.
        loc_lAbortou    = .F.
        loc_cCursorNome = THIS.this_cCursorDados

        TRY
            *-- Limpar cursores anteriores
            IF USED("cursor_4c_ListPro1")
                USE IN cursor_4c_ListPro1
            ENDIF
            IF USED("cursor_4c_ListPro2")
                USE IN cursor_4c_ListPro2
            ENDIF
            IF USED("cursor_4c_ListPro3")
                USE IN cursor_4c_ListPro3
            ENDIF
            IF USED("cursor_4c_ListPro4")
                USE IN cursor_4c_ListPro4
            ENDIF
            IF USED("cursor_4c_TmpPro3")
                USE IN cursor_4c_TmpPro3
            ENDIF
            IF USED("cursor_4c_TmpRec2")
                USE IN cursor_4c_TmpRec2
            ENDIF
            IF USED("cursor_4c_TmpRec4")
                USE IN cursor_4c_TmpRec4
            ENDIF
            IF USED(loc_cCursorNome)
                USE IN (loc_cCursorNome)
            ENDIF

            *-- Estrutura padrao identica para os 4 cursores de trabalho
            SET NULL ON
            CREATE CURSOR cursor_4c_ListPro1 (cNomeEmpre C(40), dDtInicial T NULL, ;
                dDtFinal T NULL, CEmps C(3), ncarts N(12), numes N(8), datas T NULL, ;
                nlotecs C(10), fpags C(12), dopes C(20), valor N(13,2), ValLiq N(20,9), ;
                Taxas N(9,3), noresumos C(10), iclis C(10), rclis C(50) NULL, ;
                razas C(40) NULL, opcao I, cMovimento C(30), Vencs D NULL)

            CREATE CURSOR cursor_4c_ListPro2 (cNomeEmpre C(40), dDtInicial T NULL, ;
                dDtFinal T NULL, CEmps C(3), ncarts N(12), numes N(8), datas T NULL, ;
                nlotecs C(10), fpags C(12), dopes C(20), valor N(13,2), ValLiq N(20,9), ;
                Taxas N(9,3), noresumos C(10), iclis C(10), rclis C(50) NULL, ;
                razas C(40) NULL, opcao I, cMovimento C(30), Vencs D NULL)

            CREATE CURSOR cursor_4c_ListPro3 (cNomeEmpre C(40), dDtInicial T NULL, ;
                dDtFinal T NULL, CEmps C(3), ncarts N(12), numes N(8), datas T NULL, ;
                nlotecs C(10), fpags C(12), dopes C(20), valor N(13,2), ValLiq N(20,9), ;
                Taxas N(9,3), noresumos C(10), iclis C(10), rclis C(50) NULL, ;
                razas C(40) NULL, opcao I, cMovimento C(30), Vencs D NULL)

            CREATE CURSOR cursor_4c_ListPro4 (cNomeEmpre C(40), dDtInicial T NULL, ;
                dDtFinal T NULL, CEmps C(3), ncarts N(12), numes N(8), datas T NULL, ;
                nlotecs C(10), fpags C(12), dopes C(20), valor N(13,2), ValLiq N(20,9), ;
                Taxas N(9,3), noresumos C(10), iclis C(10), rclis C(50) NULL, ;
                razas C(40) NULL, opcao I, cMovimento C(30), Vencs D NULL)
            SET NULL OFF

            *-- Obter nome da empresa (cNomeEmpre em cada linha do relatorio)
            loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cEmpresa)

            *-- Datas formatadas para SQL Server (inicio do dia / fim do dia)
            loc_cDtIniSQL = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFimSQL = "'" + ;
                            STR(YEAR(THIS.this_dDtFinal), 4) + "-" + ;
                            RIGHT("0" + TRANSFORM(MONTH(THIS.this_dDtFinal)), 2) + "-" + ;
                            RIGHT("0" + TRANSFORM(DAY(THIS.this_dDtFinal)), 2) + ;
                            " 23:59:59'"

            *-- DATETIME para filtros em SELECTs VFP nativos (secao Depositar)
            loc_dDtIni = CTOT(DTOC(THIS.this_dDtInicial))
            loc_dDtFim = CTOT(DTOC(THIS.this_dDtFinal) + " 23:59:59")

            *-- Filtros condicionais de empresa
            IF !EMPTY(THIS.this_cEmps)
                loc_cEmpresaWhereA = "a.emps = " + EscaparSQL(THIS.this_cEmps) + " AND "
                loc_cEmpresaWhereB = " AND b.emps = " + EscaparSQL(THIS.this_cEmps)
                loc_cEmpresaWhereD = " AND d.emps = " + EscaparSQL(THIS.this_cEmps)
            ELSE
                loc_cEmpresaWhereA = ""
                loc_cEmpresaWhereB = ""
                loc_cEmpresaWhereD = ""
            ENDIF

            *-- Filtros condicionais de cartao
            IF !EMPTY(THIS.this_cFpags)
                loc_cCartaoWhereB = " AND b.fpags = " + EscaparSQL(THIS.this_cFpags)
                loc_cCartaoWhereD = " AND d.fpags = " + EscaparSQL(THIS.this_cFpags)
            ELSE
                loc_cCartaoWhereB = ""
                loc_cCartaoWhereD = ""
            ENDIF

            *==================================================================
            *-- ENTRADAS (SigCdCar + SigCdCtt)
            *==================================================================
            IF THIS.this_lEntrada AND !loc_lAbortou
                loc_nOpMovimento = 1
                loc_cMovimento   = PADR("Entradas", 30)

                loc_cSQL = "SELECT " + EscaparSQL(loc_cNomeEmpresa) + " as cNomeEmpre," + ;
                           loc_cDtIniSQL + " as dDtInicial," + ;
                           loc_cDtFimSQL + " as dDtFinal," + ;
                           "a.emps as cemps,b.ncarts,a.numes,a.datas,a.nlotecs," + ;
                           "b.fpags,b.dopes,b.valos as valor," + ;
                           "(b.valos*(1-(b.taxas/100))) as ValLiq,b.taxas," + ;
                           "b.noresumos,b.iclis,b.Vencs,c.Rclis,e.razas," + ;
                           STR(loc_nOpMovimento, 1) + " as opcao," + ;
                           EscaparSQL(loc_cMovimento) + " as cMovimento " + ;
                           "FROM SigCdEmp e,SigCdCar a," + ;
                           "SigCdCtt b LEFT JOIN SigCdCli c ON c.Iclis=b.Iclis " + ;
                           "WHERE " + loc_cEmpresaWhereA + ;
                           "a.datas BETWEEN " + loc_cDtIniSQL + " AND " + loc_cDtFimSQL + ;
                           " AND a.emps=e.cemps" + ;
                           " AND a.emps=b.emps AND a.numes=b.numes" + ;
                           " AND a.Dopes=b.Dopes AND a.Nlotecs=b.Nlotecs" + ;
                           loc_cCartaoWhereB + ;
                           " ORDER BY a.emps,b.fpags,a.datas"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Listp1")
                IF loc_nResult > 0
                    SELECT cursor_4c_Listp1
                    GO TOP
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO cursor_4c_ListPro1 FROM MEMVAR
                        SELECT cursor_4c_Listp1
                    ENDSCAN
                    USE IN cursor_4c_Listp1
                ELSE
                    THIS.this_cMensagemErro = "Falha ao buscar Entradas"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *==================================================================
            IF THIS.this_lReceber AND !loc_lAbortou
                loc_nOpMovimento = 2
                loc_cMovimento   = PADR(CHR(192) + " Receber", 30)

                loc_cSQL = "SELECT " + EscaparSQL(loc_cNomeEmpresa) + " as cNomeEmpre," + ;
                           loc_cDtIniSQL + " as dDtInicial," + ;
                           loc_cDtFimSQL + " as dDtFinal," + ;
                           "d.emps as cemps,d.ncarts,d.numes,d.vencs as datas,d.nlotecs," + ;
                           "d.fpags,d.dopes,d.totres-d.totpar as valor," + ;
                           "((d.totres-d.totpar)*(1-(d.taxas/100))) as ValLiq,d.taxas," + ;
                           "d.noresumos,d.iclis,c.Rclis,e.razas," + ;
                           STR(loc_nOpMovimento, 1) + " as opcao," + ;
                           EscaparSQL(loc_cMovimento) + " as cMovimento " + ;
                           "FROM SigCdEmp e," + ;
                           "SigCdCrd d LEFT JOIN SigCdCli c ON c.Iclis=d.Iclis " + ;
                           "WHERE NOT (d.totres-d.totpar=0)" + ;
                           loc_cEmpresaWhereD + ;
                           loc_cCartaoWhereD + ;
                           " AND d.emps=e.cemps" + ;
                           " ORDER BY d.emps,d.fpags,d.vencs"

                IF USED("cursor_4c_TmpRec2")
                    USE IN cursor_4c_TmpRec2
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRec2")
                IF loc_nResult > 0
                    SELECT cNomeEmpre, dDtInicial, dDtFinal, cemps, ;
                           ncarts, numes, datas, nlotecs, fpags, dopes, valor, ValLiq, ;
                           taxas, noresumos, iclis, Rclis, razas, opcao, cMovimento ;
                        FROM cursor_4c_TmpRec2 ;
                        WHERE datas BETWEEN m.loc_dDtIni AND m.loc_dDtFim ;
                        INTO CURSOR cursor_4c_Listp2 ;
                        ORDER BY cemps, fpags, datas
                    USE IN cursor_4c_TmpRec2
                    SELECT cursor_4c_Listp2
                    GO TOP
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO cursor_4c_ListPro2 FROM MEMVAR
                        SELECT cursor_4c_Listp2
                    ENDSCAN
                    USE IN cursor_4c_Listp2
                ELSE
                    THIS.this_cMensagemErro = "Falha ao buscar " + CHR(192) + " Receber"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *==================================================================
            *-- A DEPOSITAR (SigCdCtt + SigOpFp - ainda nao depositados)
            *==================================================================
            IF THIS.this_lDepositar AND !loc_lAbortou
                loc_nOpMovimento = 3
                loc_cMovimento   = PADR(CHR(192) + " Depositar", 30)

                *-- SQL base: busca dados com colunas extras Parcs e prazos
                *-- NOT EXISTS filtra apenas transacoes ainda nao no SigCdCrd
                loc_cSQL = "SELECT " + EscaparSQL(loc_cNomeEmpresa) + " as cNomeEmpre," + ;
                           loc_cDtIniSQL + " as dDtInicial," + ;
                           loc_cDtFimSQL + " as dDtFinal," + ;
                           "b.emps as cemps,b.ncarts,b.numes,b.datas,b.Parcs,f.prazos," + ;
                           "b.nlotecs,b.fpags,b.dopes,b.valos as valor," + ;
                           "(b.valos*(1-(b.taxas/100))) as ValLiq,b.taxas," + ;
                           "b.noresumos,b.iclis,b.Vencs,c.Rclis,e.razas," + ;
                           STR(loc_nOpMovimento, 1) + " as opcao," + ;
                           EscaparSQL(loc_cMovimento) + " as cMovimento " + ;
                           "FROM SigCdEmp e,SigOpFp f," + ;
                           "SigCdCtt b LEFT JOIN SigCdCli c ON c.Iclis=b.Iclis " + ;
                           "WHERE b.Fpags=f.Fpags" + ;
                           loc_cEmpresaWhereB + ;
                           loc_cCartaoWhereB + ;
                           " AND b.emps=e.cemps" + ;
                           " AND NOT EXISTS (SELECT x.ncarts FROM SigCdCrd x" + ;
                           " WHERE x.ncarts=b.ncarts AND x.emps=b.emps)"

                IF USED("cursor_4c_TmpPro3")
                    USE IN cursor_4c_TmpPro3
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro3")
                IF loc_nResult <= 0
                    THIS.this_cMensagemErro = "Falha ao buscar " + CHR(192) + " Depositar"
                    loc_lAbortou = .T.
                ELSE
                    *-- Sub-selecao VFP baseada no tipo de deposito escolhido
                    IF THIS.this_lDepPrev
                        *-- Opcao 2: data calculada por vencimento previsto
                        SELECT DISTINCT cNomeEmpre, dDtInicial, dDtFinal, cemps, ;
                               ncarts, numes, ;
                               (datas + IIF(!EMPTY(Parcs), Parcs, 1) * prazos) AS datas, ;
                               nlotecs, fpags, dopes, valor, ;
                               valor * IIF(taxas <> 0, (1-(taxas/100)), 1) AS ValLiq, ;
                               taxas, noresumos, iclis, Rclis, razas, opcao, ;
                               PADR(CHR(192) + " Depositar (Prev. Venc.)", 30) AS cMovimento ;
                            FROM cursor_4c_TmpPro3 ;
                            WHERE (datas + IIF(!EMPTY(Parcs), Parcs, 1) * prazos) ;
                                  BETWEEN m.loc_dDtIni AND m.loc_dDtFim ;
                            INTO CURSOR cursor_4c_Listp3 ;
                            ORDER BY cemps, fpags
                    ELSE
                        *-- Opcao 1: data real de entrada
                        SELECT DISTINCT cNomeEmpre, dDtInicial, dDtFinal, cemps, ;
                               ncarts, numes, datas, nlotecs, fpags, dopes, valor, ValLiq, ;
                               taxas, noresumos, iclis, Rclis, razas, opcao, ;
                               PADR(CHR(192) + " Depositar", 30) AS cMovimento, Vencs ;
                            FROM cursor_4c_TmpPro3 ;
                            WHERE datas BETWEEN m.loc_dDtIni AND m.loc_dDtFim ;
                            INTO CURSOR cursor_4c_Listp3 ;
                            ORDER BY cemps, fpags, datas
                    ENDIF

                    SELECT cursor_4c_Listp3
                    GO TOP
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO cursor_4c_ListPro3 FROM MEMVAR
                        SELECT cursor_4c_Listp3
                    ENDSCAN
                    IF USED("cursor_4c_Listp3")
                        USE IN cursor_4c_Listp3
                    ENDIF
                    USE IN cursor_4c_TmpPro3
                ENDIF
            ENDIF

            *==================================================================
            *-- BAIXADOS (SigCdCrd - totalmente quitados: totres-totpar=0)
            *==================================================================
            IF THIS.this_lBaixa AND !loc_lAbortou
                loc_nOpMovimento = 4
                loc_cMovimento   = PADR("Baixados", 30)

                loc_cSQL = "SELECT " + EscaparSQL(loc_cNomeEmpresa) + " as cNomeEmpre," + ;
                           loc_cDtIniSQL + " as dDtInicial," + ;
                           loc_cDtFimSQL + " as dDtFinal," + ;
                           "d.emps as cemps,d.ncarts,d.numes,d.vencs as datas,d.nlotecs," + ;
                           "d.fpags,d.dopes,d.totres as valor," + ;
                           "(d.totres*(1-(d.taxas/100))) as ValLiq,d.taxas," + ;
                           "d.noresumos,d.iclis,c.Rclis,e.razas," + ;
                           STR(loc_nOpMovimento, 1) + " as opcao," + ;
                           EscaparSQL(loc_cMovimento) + " as cMovimento " + ;
                           "FROM SigCdEmp e," + ;
                           "SigCdCrd d LEFT JOIN SigCdCli c ON c.Iclis=d.Iclis " + ;
                           "WHERE (d.totres-d.totpar=0)" + ;
                           loc_cEmpresaWhereD + ;
                           loc_cCartaoWhereD + ;
                           " AND d.emps=e.cemps" + ;
                           " ORDER BY d.emps,d.fpags,d.vencs"

                IF USED("cursor_4c_TmpRec4")
                    USE IN cursor_4c_TmpRec4
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRec4")
                IF loc_nResult > 0
                    SELECT cNomeEmpre, dDtInicial, dDtFinal, cemps, ;
                           ncarts, numes, datas, nlotecs, fpags, dopes, valor, ValLiq, ;
                           taxas, noresumos, iclis, Rclis, razas, opcao, cMovimento ;
                        FROM cursor_4c_TmpRec4 ;
                        WHERE datas BETWEEN m.loc_dDtIni AND m.loc_dDtFim ;
                        INTO CURSOR cursor_4c_Listp4 ;
                        ORDER BY cemps, fpags, datas
                    USE IN cursor_4c_TmpRec4
                    SELECT cursor_4c_Listp4
                    GO TOP
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO cursor_4c_ListPro4 FROM MEMVAR
                        SELECT cursor_4c_Listp4
                    ENDSCAN
                    USE IN cursor_4c_Listp4
                ELSE
                    THIS.this_cMensagemErro = "Falha ao buscar Baixados"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *==================================================================
            *-- UNION ALL: consolida todos os tipos em cursor final do relatorio
            *==================================================================
            IF !loc_lAbortou AND ( THIS.this_lEntrada OR THIS.this_lReceber OR ;
               THIS.this_lDepositar OR THIS.this_lBaixa )
                SELECT ;
                    cNomeEmpre, dDtInicial, dDtFinal, CEmps, ncarts, numes, ;
                    datas, nlotecs, fpags, dopes, valor, ValLiq, Taxas, ;
                    noresumos, iclis, rclis, razas, opcao, cMovimento, Vencs ;
                    FROM cursor_4c_ListPro1 ;
                UNION ALL ;
                SELECT ;
                    cNomeEmpre, dDtInicial, dDtFinal, CEmps, ncarts, numes, ;
                    datas, nlotecs, fpags, dopes, valor, ValLiq, Taxas, ;
                    noresumos, iclis, rclis, razas, opcao, cMovimento, Vencs ;
                    FROM cursor_4c_ListPro2 ;
                UNION ALL ;
                SELECT ;
                    cNomeEmpre, dDtInicial, dDtFinal, CEmps, ncarts, numes, ;
                    datas, nlotecs, fpags, dopes, valor, ValLiq, Taxas, ;
                    noresumos, iclis, rclis, razas, opcao, cMovimento, Vencs ;
                    FROM cursor_4c_ListPro3 ;
                UNION ALL ;
                SELECT ;
                    cNomeEmpre, dDtInicial, dDtFinal, CEmps, ncarts, numes, ;
                    datas, nlotecs, fpags, dopes, valor, ValLiq, Taxas, ;
                    noresumos, iclis, rclis, razas, opcao, cMovimento, Vencs ;
                    FROM cursor_4c_ListPro4 ;
                INTO CURSOR (m.loc_cCursorNome) READWRITE ;
                ORDER BY razas
            ENDIF

            *-- Limpar cursores de trabalho intermediarios
            IF USED("cursor_4c_ListPro1")
                USE IN cursor_4c_ListPro1
            ENDIF
            IF USED("cursor_4c_ListPro2")
                USE IN cursor_4c_ListPro2
            ENDIF
            IF USED("cursor_4c_ListPro3")
                USE IN cursor_4c_ListPro3
            ENDIF
            IF USED("cursor_4c_ListPro4")
                USE IN cursor_4c_ListPro4
            ENDIF

            loc_lSucesso = !loc_lAbortou
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de um cursor de parametros salvos
    * Em REPORT BOs nao ha persistencia de registro, mas o framework pode chamar
    * este metodo para repopular os filtros desde um cursor de "ultimo uso".
    * par_cAliasCursor: alias do cursor com as colunas dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
                THIS.this_cMensagemErro = "Alias do cursor invalido"
            ELSE
                IF !USED(par_cAliasCursor)
                    THIS.this_cMensagemErro = "Cursor " + par_cAliasCursor + " nao esta aberto"
                ELSE
                    SELECT (par_cAliasCursor)
                    IF !EOF()
                        IF TYPE(par_cAliasCursor + ".dDtInicial") = "D" OR ;
                           TYPE(par_cAliasCursor + ".dDtInicial") = "T"
                            THIS.this_dDtInicial = TratarNulo(EVALUATE(par_cAliasCursor + ".dDtInicial"), "D")
                        ENDIF
                        IF TYPE(par_cAliasCursor + ".dDtFinal") = "D" OR ;
                           TYPE(par_cAliasCursor + ".dDtFinal") = "T"
                            THIS.this_dDtFinal = TratarNulo(EVALUATE(par_cAliasCursor + ".dDtFinal"), "D")
                        ENDIF
                        IF TYPE(par_cAliasCursor + ".cemps") = "C"
                            THIS.this_cEmps = TratarNulo(EVALUATE(par_cAliasCursor + ".cemps"), "C")
                        ENDIF
                        IF TYPE(par_cAliasCursor + ".razas") = "C"
                            THIS.this_cRazas = TratarNulo(EVALUATE(par_cAliasCursor + ".razas"), "C")
                        ENDIF
                        IF TYPE(par_cAliasCursor + ".fpags") = "C"
                            THIS.this_cFpags = TratarNulo(EVALUATE(par_cAliasCursor + ".fpags"), "C")
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Cursor vazio"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Bloqueado em REPORT BO (RelatorioBase nao persiste registros).
    * Mantido para satisfazer contratos genericos do framework.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: " + ALLTRIM(THIS.this_cTituloRelatorio) + " " + ;
            CHR(233) + " um relat" + CHR(243) + "rio (sem persist" + CHR(234) + "ncia)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Bloqueado em REPORT BO (RelatorioBase nao persiste registros).
    * Mantido para satisfazer contratos genericos do framework.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: " + ALLTRIM(THIS.this_cTituloRelatorio) + " " + ;
            CHR(233) + " um relat" + CHR(243) + "rio (sem persist" + CHR(234) + "ncia)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - REPORT BO nao tem chave primaria de registro.
    * Devolve uma assinatura unica para fins de auditoria (titulo+periodo).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTituloRelatorio)
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtInicial)
        ENDIF
        IF !EMPTY(THIS.this_dDtFinal)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtFinal)
        ENDIF
        IF !EMPTY(THIS.this_cEmps)
            loc_cChave = loc_cChave + "|emp:" + ALLTRIM(THIS.this_cEmps)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra a execucao do relatorio em LogAuditoria.
    * Override de RelatorioBase para gravar acao real (impressao/visualizacao).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cOperacao
        loc_lSucesso = .F.
        loc_cOperacao = IIF(VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao), ;
                            par_cOperacao, "VISUALIZAR")
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Operacao, Tabela, ChaveRegistro, Usuario, DataHora, DadosNovos) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cOperacao) + "," + ;
                       EscaparSQL("RELATORIO_CARTOES") + "," + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + "," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(ALLTRIM(THIS.this_cTituloRelatorio)) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao registrar auditoria"
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve bloquear o relatorio: apenas registra erro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Cartoes")
            USE IN cursor_4c_Cartoes
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
