*==============================================================================
* SIGRECMMBO.PRG
* Business Object para Relatorio de Mapa de Comissao Por Vendedor
*
* Herda de RelatorioBase
* Formulario original: SIGRECMM.SCX (frmrelatorio)
* Tabelas: SigCmCab, SigCmItn, SigMvCab, SigMvItn, SigCdOpe,
*           SigCdPro, SigMvPar, SigOpFp, SigCdCli, SigCdTom
*==============================================================================

DEFINE CLASS sigrecmmBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCodMapa    = ""   && getCods  - Codigo do Relatorio (SigCmCab.Cods) MaxLength=40
    this_cCodVens    = ""   && getCodVens - Codigo do Vendedor filtro MaxLength=10

    *-- Nomes dos cursores de trabalho
    this_cCursorAnalitico  = "cursor_4c_Analitico"
    this_cCursorImpressao  = "cursor_4c_Impressao"
    this_cCursorCabecalho  = "cursor_4c_Cabecalho"
    this_cCursorExcel      = "cursor_4c_Excel"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria os cursores de trabalho do relatorio
    * Equivalente ao Load do frmrelatorio original
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_oErro
        TRY
            IF USED(THIS.this_cCursorAnalitico)
                USE IN (THIS.this_cCursorAnalitico)
            ENDIF
            IF USED(THIS.this_cCursorImpressao)
                USE IN (THIS.this_cCursorImpressao)
            ENDIF
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            IF USED(THIS.this_cCursorExcel)
                USE IN (THIS.this_cCursorExcel)
            ENDIF

            SET NULL ON

            CREATE CURSOR cursor_4c_Analitico ;
                (CodVens   C(10), Datas     D(8),    EmpDopNums C(29), ;
                 Cpros      C(14), Mercs     C(3),    CGrus      C(3),  ;
                 SGrus      C(6),  FPags     C(12),   ValVdaCom  N(12,2), ;
                 ValComiss  N(12,2), TpComiss C(3),   PctComiss  N(12,2), ;
                 CodFaixas  N(2),   Apagar   C(1))

            CREATE CURSOR cursor_4c_Impressao ;
                (Datas C(10), V01 N(12,2), V02 N(12,2), V03 N(12,2), V04 N(12,2), ;
                 V05 N(12,2), V06 N(12,2), V07 N(12,2), V08 N(12,2), V09 N(12,2), ;
                 V10 N(12,2), V11 N(12,2), V12 N(12,2), V13 N(13,2), TotalV N(12,2))

            CREATE CURSOR cursor_4c_Cabecalho ;
                (V01 M(4), V02 M(4), V03 M(4), V04 M(4), V05 M(4), V06 M(4), ;
                 V07 M(4), V08 M(4), V09 M(4), V10 M(4), V11 M(4), V12 M(4), ;
                 V13 M(4), TotalV M(4), Titulo C(254), Subtitulo C(254), ;
                 Periodo C(254), Datas M(4))

            CREATE CURSOR cursor_4c_Excel ;
                (Datas C(10), V01 C(12), V02 C(12), V03 C(12), V04 C(12), ;
                 V05 C(12), V06 C(12), V07 C(12), V08 C(12), V09 C(12), ;
                 V10 C(12), V11 C(12), V12 C(12), V13 C(12), TotalV C(12))

            SET NULL OFF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursores - Fecha todos os cursores de trabalho
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursores()
        IF USED(THIS.this_cCursorAnalitico)
            USE IN (THIS.this_cCursorAnalitico)
        ENDIF
        IF USED(THIS.this_cCursorImpressao)
            USE IN (THIS.this_cCursorImpressao)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        IF USED(THIS.this_cCursorExcel)
            USE IN (THIS.this_cCursorExcel)
        ENDIF
        IF USED("crVendas")
            USE IN crVendas
        ENDIF
        IF USED("crSintetico")
            USE IN crSintetico
        ENDIF
        IF USED("crResps")
            USE IN crResps
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa o mapa de comissao por vendedor
    * Equivalente ao PROCEDURE processamento do frmrelatorio original
    * Popula: cursor_4c_Analitico, cursor_4c_Impressao, cursor_4c_Cabecalho
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_lcPrc, loc_lcFvd
        LOCAL loc_pDtI, loc_pDtF
        LOCAL loc_lnPro, loc_lnPct, loc_lnTtl, loc_lnPag, loc_lnCpg
        LOCAL loc_lnPg1, loc_lnCm1, loc_lcTip, loc_lcTip2
        LOCAL loc_lnGe1, loc_lnGe2, loc_lnDif
        LOCAL loc_lcEdn, loc_lcVen, loc_lnVal, loc_lnCmR
        LOCAL loc_lcCol, loc_lcNom, loc_lcSub, loc_lcTit, loc_lcPer
        LOCAL loc_lnVvd, loc_lnVmt, loc_lnAti, loc_lnDia, loc_ldDat
        LOCAL loc_lnCnt, loc_llAti, loc_nI
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCodMapa)
                THIS.this_cMensagemErro = "Informe o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio"
                loc_lResultado = .F.
            ENDIF

            THIS.InicializarCursores()

            SELECT cursor_4c_Analitico
            ZAP
            SELECT cursor_4c_Impressao
            ZAP
            SELECT cursor_4c_Cabecalho
            ZAP

            loc_lcPrc = PADR(THIS.this_cCodMapa, 40)
            loc_lcFvd = PADR(THIS.this_cCodVens, 10)

            *-- Cabecalho da Tabela de Comissao Selecionada
            loc_cSQL = "Select a.* " + ;
                       "From SigCmCab a " + ;
                       "Where a.Cods = " + EscaparSQL(loc_lcPrc)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCmCab")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar cabe" + CHR(231) + CHR(227) + "lho do mapa (LocalCmCab)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lResultado = .F.
            ENDIF
            SELECT LocalCmCab
            GO TOP

            loc_pDtI = FormatarDataSQL(LocalCmCab.DtInis)
            loc_pDtF = FormatarDataSQL(LocalCmCab.DtFims)

            *-- Todas as Vendas do Periodo Selecionadas que Pagam Comissao
            loc_cSQL = "Select a.Datas, a.EmpDopNums, a.Valos, a.ValVars, a.Vends, a.Resps, " + ;
                       "b.CPros, b.Moedas, b.MoeVals, b.Opers, b.Totas, c.Mercs, c.CGrus, c.SGrus " + ;
                       "From SigCdOpe d " + ;
                       "Inner Join SigMvCab a On d.Dopes = a.Dopes " + ;
                       "Left Join SigMvItn b On a.EmpDopNums = b.EmpDopNums " + ;
                       "Left Join SigCdPro c On b.Cpros = c.CPros " + ;
                       "Where a.Datas Between " + loc_pDtI + " And " + loc_pDtF + " And " + ;
                       "a.Emps = '" + ALLTRIM(LocalCmCab.Emps) + "' And " + ;
                       "a.LCancelas = 0 And a.Valos <> 0 And " + ;
                       "(b.Opers = 'S' Or (b.Opers = 'E' And d.CalcFecs = 1)) And " + ;
                       "d.Dopes In (" + ;
                       "Select o.Dopes From SigCdTom t, SigCdOpe o " + ;
                       "Where t.nChkSdfs = 1 And t.Codigos = o.TipoOps) " + ;
                       "Order By a.EmpDopNums"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalVendas")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar vendas do per" + CHR(237) + "odo (LocalVendas)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                IF USED("LocalCmCab")
                    USE IN LocalCmCab
                ENDIF
                loc_lResultado = .F.
            ENDIF

            SELECT LocalVendas
            INDEX ON EmpDopNums TAG EmpDopNums
            UPDATE LocalVendas ;
                SET Valos = Valos * IIF(Opers = "E", -1, 1), ;
                    Totas = Totas * IIF(Opers = "E", -1, 1)

            *-- EmpDopNums das Movimentacoes a Serem Processadas
            SELECT DISTINCT EmpDopNums, ValVars, Opers ;
              FROM LocalVendas ;
              INTO CURSOR LocalEdns READWRITE
            SELECT LocalEdns
            INDEX ON EmpDopNums TAG EmpDopNums

            *-- Loop principal: calcula comissao por movimentacao
            SELECT LocalEdns
            GO TOP
            SCAN
                loc_lcEdn = LocalEdns.EmpDopNums
                loc_lnGe1 = 0
                loc_lnGe2 = 0

                IF LocalEdns.ValVars <> 0
                    SELECT SUM(Totas) AS TotProds ;
                      FROM LocalVendas ;
                     WHERE EmpDopNums = loc_lcEdn ;
                      INTO CURSOR LocalTotProds
                    SELECT LocalTotProds
                    GO TOP
                    loc_lnPro = IIF(EOF(), 0, LocalTotProds.TotProds)
                    USE IN LocalTotProds

                    SELECT LocalVendas
                    SET ORDER TO TAG EmpDopNums
                    SEEK loc_lcEdn
                    SCAN WHILE EmpDopNums = loc_lcEdn
                        loc_lnPct = IIF(loc_lnPro = 0, 0, (LocalVendas.Totas * 100) / loc_lnPro)
                        loc_lnTtl = (LocalEdns.ValVars * loc_lnPct) / 100
                        REPLACE Totas WITH Totas + loc_lnTtl IN LocalVendas
                    ENDSCAN
                ENDIF

                SELECT SUM(Totas) AS TotProds ;
                  FROM LocalVendas ;
                 WHERE EmpDopNums = loc_lcEdn ;
                  INTO CURSOR LocalTotProds
                SELECT LocalTotProds
                GO TOP
                loc_lnPro = IIF(EOF(), 0, LocalTotProds.TotProds)
                USE IN LocalTotProds

                *-- Formas de Pagamento que Pagam Comissao
                loc_cSQL = "Select b.FPags, b.Trocos, Sum(a.Valos * a.CotFpgs) as Valos, b.FPComiss " + ;
                           "From SigMvPar a, SigOpFp b " + ;
                           "Where a.EmpDopNums = " + EscaparSQL(loc_lcEdn) + " And " + ;
                           "a.FPags = b.FPags And Not b.BxComis = 2 " + ;
                           "Group by b.FPags, b.Trocos, b.FPComiss"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalPagtos1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar pagamentos (LocalPagtos1)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    IF USED("LocalCmCab")
                        USE IN LocalCmCab
                    ENDIF
                    IF USED("LocalVendas")
                        USE IN LocalVendas
                    ENDIF
                    IF USED("LocalEdns")
                        USE IN LocalEdns
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
                UPDATE LocalPagtos1 SET Valos = Valos * IIF(LocalEdns.Opers = "E", -1, 1)

                SELECT LocalVendas
                SET ORDER TO TAG EmpDopNums
                SEEK loc_lcEdn
                SCAN WHILE EmpDopNums = loc_lcEdn
                    loc_lnPct = IIF(loc_lnPro = 0, 0, (LocalVendas.Totas * 100) / loc_lnPro)

                    SELECT LocalPagtos1
                    GO TOP
                    IF EOF()
                        loc_lnPag = ((LocalPagtos1.Valos * IIF(LocalPagtos1.Trocos = 1, -1, 1)) * loc_lnPct) / 100

                        IF !EMPTY(LocalVendas.Vends) AND !EMPTY(LocalCmCab.PctVd1)
                            loc_lnPg1 = (loc_lnPag * LocalCmCab.PctVd1) / 100
                            IF EMPTY(LocalVendas.Resps) OR EMPTY(LocalCmCab.PctVd2)
                                loc_lnPg1 = loc_lnPag
                            ENDIF

                            INSERT INTO cursor_4c_Analitico ;
                                (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                                 FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                                VALUES (LocalVendas.Vends, LocalVendas.Datas, LocalVendas.EmpDopNums, ;
                                        LocalVendas.CPros, LocalVendas.Mercs, LocalVendas.CGrus, ;
                                        LocalVendas.SGrus, "NENHUMA", loc_lnPg1, 0, "", 0, "S")
                            loc_lnGe1 = loc_lnGe1 + loc_lnPg1
                            loc_lnGe2 = loc_lnGe2 + cursor_4c_Analitico.ValVdaCom
                        ENDIF

                        IF !EMPTY(LocalVendas.Resps) AND !EMPTY(LocalCmCab.PctVd2)
                            loc_lnPg1 = (loc_lnPag * LocalCmCab.PctVd2) / 100
                            IF EMPTY(LocalVendas.Vends) OR EMPTY(LocalCmCab.PctVd1)
                                loc_lnPg1 = loc_lnPag
                            ENDIF

                            INSERT INTO cursor_4c_Analitico ;
                                (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                                 FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                                VALUES (LocalVendas.Resps, LocalVendas.Datas, LocalVendas.EmpDopNums, ;
                                        LocalVendas.CPros, LocalVendas.Mercs, LocalVendas.CGrus, ;
                                        LocalVendas.SGrus, "NENHUMA", loc_lnPg1, 0, "", 0, "S")
                            loc_lnGe1 = loc_lnGe1 + loc_lnPg1
                            loc_lnGe2 = loc_lnGe2 + cursor_4c_Analitico.ValVdaCom
                        ENDIF
                    ELSE
                        SELECT LocalPagtos1
                        SCAN
                            loc_lnPag = ((LocalPagtos1.Valos * IIF(LocalPagtos1.Trocos = 1, -1, 1)) * loc_lnPct) / 100
                            loc_lnCpg = (loc_lnPag * LocalPagtos1.FPComiss) / 100

                            IF !EMPTY(LocalVendas.Vends) AND !EMPTY(LocalCmCab.PctVd1)
                                loc_lnPg1 = (loc_lnPag * LocalCmCab.PctVd1) / 100
                                loc_lnCm1 = (loc_lnCpg * LocalCmCab.PctVd1) / 100
                                IF EMPTY(LocalVendas.Resps) OR EMPTY(LocalCmCab.PctVd2)
                                    loc_lnPg1 = loc_lnPag
                                    loc_lnCm1 = loc_lnCpg
                                ENDIF
                                loc_lcTip = IIF(EMPTY(loc_lnCm1), "", "PAG")

                                INSERT INTO cursor_4c_Analitico ;
                                    (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                                     FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                                    VALUES (LocalVendas.Vends, LocalVendas.Datas, LocalVendas.EmpDopNums, ;
                                            LocalVendas.CPros, LocalVendas.Mercs, LocalVendas.CGrus, ;
                                            LocalVendas.SGrus, LocalPagtos1.FPags, ;
                                            loc_lnPg1, loc_lnCm1, loc_lcTip, LocalPagtos1.FPComiss, "S")
                                loc_lnGe1 = loc_lnGe1 + loc_lnPg1
                                loc_lnGe2 = loc_lnGe2 + cursor_4c_Analitico.ValVdaCom
                            ENDIF

                            IF !EMPTY(LocalVendas.Resps) AND !EMPTY(LocalCmCab.PctVd2)
                                loc_lnPg1 = (loc_lnPag * LocalCmCab.PctVd2) / 100
                                loc_lnCm1 = (loc_lnCpg * LocalCmCab.PctVd2) / 100
                                IF EMPTY(LocalVendas.Vends) OR EMPTY(LocalCmCab.PctVd1)
                                    loc_lnPg1 = loc_lnPag
                                    loc_lnCm1 = loc_lnCpg
                                ENDIF
                                loc_lcTip = IIF(EMPTY(loc_lnCm1), "", "PAG")

                                INSERT INTO cursor_4c_Analitico ;
                                    (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                                     FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                                    VALUES (LocalVendas.Resps, LocalVendas.Datas, LocalVendas.EmpDopNums, ;
                                            LocalVendas.CPros, LocalVendas.Mercs, LocalVendas.CGrus, ;
                                            LocalVendas.SGrus, LocalPagtos1.FPags, ;
                                            loc_lnPg1, loc_lnCm1, loc_lcTip, LocalPagtos1.FPComiss, "S")
                                loc_lnGe1 = loc_lnGe1 + loc_lnPg1
                                loc_lnGe2 = loc_lnGe2 + cursor_4c_Analitico.ValVdaCom
                            ENDIF
                        ENDSCAN
                    ENDIF
                    SELECT LocalVendas
                ENDSCAN

                IF ROUND(loc_lnGe1, 2) <> loc_lnGe2
                    loc_lnDif = ROUND(loc_lnGe1, 2) - loc_lnGe2
                    SELECT cursor_4c_Analitico
                    GO BOTTOM
                    REPLACE ValVdaCom WITH ValVdaCom + loc_lnDif IN cursor_4c_Analitico
                ENDIF

                IF USED("LocalPagtos1")
                    USE IN LocalPagtos1
                ENDIF
            ENDSCAN

            *-- Produtos da Tabela de Comissao Selecionada
            loc_cSQL = "Select a.Mercs, a.CGrus, a.SGrus, a.PPctFixs " + ;
                       "From SigCmItn a " + ;
                       "Where a.fkChaves = '" + ALLTRIM(LocalCmCab.pkChaves) + "' And a.Tipos = 'PRO'"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCmPro")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar produtos do mapa (LocalCmPro)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                IF USED("LocalCmCab")
                    USE IN LocalCmCab
                ENDIF
                IF USED("LocalVendas")
                    USE IN LocalVendas
                ENDIF
                IF USED("LocalEdns")
                    USE IN LocalEdns
                ENDIF
                loc_lResultado = .F.
            ENDIF

            *-- Aplica produtos configurados no mapa (mantendo ou calculando % fixo)
            SELECT LocalCmPro
            SCAN
                DO CASE
                    CASE !EMPTY(LocalCmPro.Mercs) AND !EMPTY(LocalCmPro.CGrus) AND !EMPTY(LocalCmPro.SGrus)
                        UPDATE cursor_4c_Analitico ;
                           SET Apagar   = "N", ;
                               ValComiss = IIF(EMPTY(LocalCmPro.PPctFixs), ValComiss, (ValVdaCom * LocalCmPro.PPctFixs) / 100), ;
                               PctComiss = IIF(EMPTY(LocalCmPro.PPctFixs), PctComiss, LocalCmPro.PPctFixs), ;
                               TpComiss  = IIF(EMPTY(LocalCmPro.PPctFixs), TpComiss, "PRO") ;
                         WHERE Mercs = LocalCmPro.Mercs AND CGrus = LocalCmPro.CGrus AND !SGrus = LocalCmPro.SGrus

                    CASE !EMPTY(LocalCmPro.Mercs) AND !EMPTY(LocalCmPro.CGrus)
                        UPDATE cursor_4c_Analitico ;
                           SET Apagar   = "N", ;
                               ValComiss = IIF(EMPTY(LocalCmPro.PPctFixs), ValComiss, (ValVdaCom * LocalCmPro.PPctFixs) / 100), ;
                               PctComiss = IIF(EMPTY(LocalCmPro.PPctFixs), PctComiss, LocalCmPro.PPctFixs), ;
                               TpComiss  = IIF(EMPTY(LocalCmPro.PPctFixs), TpComiss, "PRO") ;
                         WHERE Mercs = LocalCmPro.Mercs AND CGrus = LocalCmPro.CGrus

                    CASE !EMPTY(LocalCmPro.Mercs)
                        UPDATE cursor_4c_Analitico ;
                           SET Apagar   = "N", ;
                               ValComiss = IIF(EMPTY(LocalCmPro.PPctFixs), ValComiss, (ValVdaCom * LocalCmPro.PPctFixs) / 100), ;
                               PctComiss = IIF(EMPTY(LocalCmPro.PPctFixs), PctComiss, LocalCmPro.PPctFixs), ;
                               TpComiss  = IIF(EMPTY(LocalCmPro.PPctFixs), TpComiss, "PRO") ;
                         WHERE Mercs = LocalCmPro.Mercs
                ENDCASE
            ENDSCAN

            DELETE FROM cursor_4c_Analitico WHERE Apagar = "S"

            *-- Faixas de Metas da Tabela de Comissao Selecionada
            loc_cSQL = "Select a.CodFaixas, a.FxaInis, a.FxaFims, a.PctFaixas, a.Bonus " + ;
                       "From SigCmItn a " + ;
                       "Where a.fkChaves = '" + ALLTRIM(LocalCmCab.pkChaves) + "' And a.Tipos = 'MET'"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCmFxa")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar faixas do mapa (LocalCmFxa)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                IF USED("LocalCmCab")
                    USE IN LocalCmCab
                ENDIF
                IF USED("LocalVendas")
                    USE IN LocalVendas
                ENDIF
                IF USED("LocalEdns")
                    USE IN LocalEdns
                ENDIF
                IF USED("LocalCmPro")
                    USE IN LocalCmPro
                ENDIF
                loc_lResultado = .F.
            ENDIF

            *-- Totais de venda por vendedor para calculo de faixas
            SELECT CodVens, SUM(ValVdaCom) AS ValVendas ;
              FROM cursor_4c_Analitico ;
             GROUP BY CodVens ;
             ORDER BY CodVens ;
              INTO CURSOR crVendas READWRITE

            SELECT crVendas
            SCAN
                loc_lcVen = crVendas.CodVens
                loc_lnVal = crVendas.ValVendas

                SELECT LocalCmFxa
                GO TOP
                LOCATE FOR BETWEEN(loc_lnVal, LocalCmFxa.FxaInis, LocalCmFxa.FxaFims)
                IF !EOF()
                    UPDATE cursor_4c_Analitico ;
                       SET CodFaixas = LocalCmFxa.CodFaixas ;
                     WHERE CodVens = loc_lcVen

                    IF !EMPTY(LocalCmFxa.PctFaixas)
                        UPDATE cursor_4c_Analitico ;
                           SET TpComiss  = "MET", ;
                               PctComiss = IIF(EMPTY(LocalCmFxa.PctFaixas), PctComiss, LocalCmFxa.PctFaixas), ;
                               ValComiss = (ValVdaCom * LocalCmFxa.PctFaixas) / 100 ;
                         WHERE CodVens = loc_lcVen AND !TpComiss = "PRO"
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Vendedores da Tabela de Comissao para calculo de Responsaveis e Bonus
            loc_cSQL = "Select a.CodVens, a.VMetas, a.SalBases, a.CodResps, a.RPctFixs " + ;
                       "From SigCmItn a " + ;
                       "Where a.fkChaves = '" + ALLTRIM(LocalCmCab.pkChaves) + "' And a.Tipos = 'VEN'"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCmVen")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar vendedores do mapa (LocalCmVen)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                IF USED("LocalCmCab")
                    USE IN LocalCmCab
                ENDIF
                IF USED("LocalVendas")
                    USE IN LocalVendas
                ENDIF
                IF USED("LocalEdns")
                    USE IN LocalEdns
                ENDIF
                IF USED("LocalCmPro")
                    USE IN LocalCmPro
                ENDIF
                IF USED("LocalCmFxa")
                    USE IN LocalCmFxa
                ENDIF
                loc_lResultado = .F.
            ENDIF

            *-- Lanca registros de responsaveis no cursor analitico
            SELECT LocalCmVen
            SCAN
                IF !EMPTY(LocalCmVen.CodResps) AND !EMPTY(LocalCmVen.RPctFixs)
                    SELECT crVendas
                    GO TOP
                    LOCATE FOR CodVens = LocalCmVen.CodVens
                    IF !EOF()
                        loc_lnCmR = (crVendas.ValVendas * LocalCmVen.RPctFixs) / 100

                        INSERT INTO cursor_4c_Analitico ;
                            (CodVens, Datas, EmpDopNums, Cpros, Mercs, CGrus, SGrus, ;
                             FPags, ValVdaCom, ValComiss, TpComiss, PctComiss, Apagar) ;
                            VALUES (LocalCmVen.CodResps, LocalCmCab.DtFims, ;
                                    "Vendedor " + ALLTRIM(LocalCmVen.CodVens), ;
                                    "", "", "", "", "", crVendas.ValVendas, loc_lnCmR, "REP", ;
                                    LocalCmVen.RPctFixs, "N")
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Cursor de responsaveis para subtitulo
            SELECT CodVens, SUM(ValVdaCom) AS ValVdaCom, SUM(ValComiss) AS ValComiss ;
              FROM cursor_4c_Analitico ;
             WHERE TpComiss = "REP" ;
             GROUP BY CodVens ;
             ORDER BY CodVens ;
              INTO CURSOR crResps READWRITE

            SET POINT TO ","
            SET SEPARATOR TO "."

            loc_lcSub = ""
            SELECT crResps
            SCAN
                loc_lcNom = ""
                loc_cSQL = "Select RClis From SigCdCli Where IClis = '" + ALLTRIM(crResps.CodVens) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalNomVen")
                IF loc_nResult > 0
                    SELECT LocalNomVen
                    GO TOP
                    IF !EOF()
                        loc_lcNom = ALLTRIM(LocalNomVen.RClis)
                    ENDIF
                    USE IN LocalNomVen
                ENDIF

                loc_lcSub = loc_lcSub + ;
                    IIF(EMPTY(loc_lcSub), "", " / ") + ALLTRIM(crResps.CodVens) + ;
                    IIF(EMPTY(loc_lcNom), "", " (" + loc_lcNom + ")") + ;
                    " - V: " + ALLTRIM(TRANSFORM(crResps.ValVdaCom, "999,999,999.99")) + ;
                    " - C: " + ALLTRIM(TRANSFORM(crResps.ValComiss, "999,999,999.99"))
            ENDSCAN

            SET POINT TO "."
            SET SEPARATOR TO ","

            loc_lcTit = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o Por Vendedores - " + ;
                        ALLTRIM(PROPER(loc_lcPrc))
            loc_lcPer = "Per" + CHR(237) + "odo: " + DTOC(LocalCmCab.DtInis) + ;
                        " at" + CHR(233) + " " + DTOC(LocalCmCab.DtFims)

            INSERT INTO cursor_4c_Cabecalho (TotalV, Titulo, Subtitulo, Periodo) ;
                VALUES ("TOTAL", loc_lcTit, loc_lcSub, loc_lcPer)

            *-- Cursor sintetico: vendas por vendedor/data (filtrado por getCodVens)
            SELECT CodVens, Datas, SUM(ValVdaCom) AS ValVdaCom ;
              FROM cursor_4c_Analitico ;
             WHERE IIF(EMPTY(loc_lcFvd), .T., CodVens = loc_lcFvd) ;
             GROUP BY CodVens, Datas ;
             ORDER BY CodVens, Datas ;
              INTO CURSOR crSintetico READWRITE

            *-- Cursor de vendedores com totais (filtrado por getCodVens)
            SELECT 99 AS Ordem, a.CodVens, SUM(a.ValVdaCom) AS ValVdaCom, SUM(a.ValComiss) AS ValComiss ;
              FROM cursor_4c_Analitico a, LocalCmVen b ;
             WHERE a.CodVens = b.CodVens AND ;
                   IIF(EMPTY(loc_lcFvd), .T., a.CodVens = loc_lcFvd) ;
             GROUP BY a.CodVens ;
             ORDER BY a.CodVens ;
              INTO CURSOR crVends READWRITE

            *-- Garante que todos os vendedores do mapa estejam em crVends
            SELECT LocalCmVen
            SCAN
                IF EMPTY(loc_lcFvd) OR (!EMPTY(loc_lcFvd) AND CodVens = loc_lcFvd)
                    SELECT crVends
                    LOCATE FOR CodVens = LocalCmVen.CodVens
                    IF EOF()
                        INSERT INTO crVends (CodVens) VALUES (LocalCmVen.CodVens)
                    ENDIF
                ENDIF
            ENDSCAN

            SELECT crVends
            INDEX ON CodVens TAG CodVens
            loc_lnCnt = 0
            SCAN
                loc_lnCnt = loc_lnCnt + 1
                REPLACE Ordem WITH loc_lnCnt IN crVends
            ENDSCAN

            *-- Intervalo de datas do periodo (linhas de cursor_4c_Impressao)
            loc_lnDia = (LocalCmCab.DtFims - LocalCmCab.DtInis) + 1
            loc_ldDat = LocalCmCab.DtInis
            FOR loc_nI = 1 TO loc_lnDia
                INSERT INTO cursor_4c_Impressao (Datas) VALUES (DTOC(loc_ldDat))
                loc_ldDat = loc_ldDat + 1
            NEXT
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("VENDAS    ")
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("COMISS" + CHR(195) + "O  ")
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("BONUS     ")
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("METAS     ")
            INSERT INTO cursor_4c_Impressao (Datas) VALUES ("ATINGIDO  ")

            *-- Preenche colunas V01..V13 no cursor de impressao por vendedor
            SELECT crVends
            SCAN
                loc_lcCol = "V" + PADL(crVends.Ordem, 2, "0")

                loc_lcNom = ""
                loc_cSQL = "Select RClis From SigCdCli Where IClis = '" + ALLTRIM(crVends.CodVens) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalNomVen")
                IF loc_nResult > 0
                    SELECT LocalNomVen
                    GO TOP
                    IF !EOF()
                        loc_lcNom = PADR(ALLTRIM(LocalNomVen.RClis), 10)
                    ENDIF
                    USE IN LocalNomVen
                ENDIF

                SELECT cursor_4c_Cabecalho
                GO TOP
                REPLACE &loc_lcCol. WITH ALLTRIM(crVends.CodVens) + CHR(13) + loc_lcNom ;
                    IN cursor_4c_Cabecalho

                loc_lnVvd = crVends.ValVdaCom
                loc_lnVmt = 0

                SELECT cursor_4c_Impressao
                GO TOP
                LOCATE FOR Datas = "VENDAS    "
                IF !EOF()
                    REPLACE &loc_lcCol. WITH loc_lnVvd IN cursor_4c_Impressao
                ENDIF

                SELECT cursor_4c_Impressao
                GO TOP
                LOCATE FOR Datas = "COMISS" + CHR(195) + "O  "
                IF !EOF()
                    REPLACE &loc_lcCol. WITH crVends.ValComiss IN cursor_4c_Impressao
                ENDIF

                loc_llAti = .F.
                SELECT cursor_4c_Impressao
                GO TOP
                LOCATE FOR Datas = "METAS     "
                IF !EOF()
                    SELECT LocalCmVen
                    GO TOP
                    LOCATE FOR CodVens = crVends.CodVens
                    IF !EOF()
                        loc_lnVmt = LocalCmVen.VMetas
                        REPLACE &loc_lcCol. WITH loc_lnVmt IN cursor_4c_Impressao
                        loc_llAti = (loc_lnVvd >= loc_lnVmt)
                    ENDIF
                ENDIF

                IF loc_llAti
                    SELECT cursor_4c_Impressao
                    GO TOP
                    LOCATE FOR Datas = "BONUS     "
                    IF !EOF()
                        SELECT LocalCmFxa
                        GO TOP
                        LOCATE FOR BETWEEN(loc_lnVvd, LocalCmFxa.FxaInis, LocalCmFxa.FxaFims)
                        IF !EOF()
                            REPLACE &loc_lcCol. WITH (crVends.ValComiss * LocalCmFxa.Bonus) / 100 ;
                                IN cursor_4c_Impressao
                        ENDIF
                    ENDIF
                ENDIF

                SELECT cursor_4c_Impressao
                GO TOP
                LOCATE FOR Datas = "ATINGIDO  "
                IF !EOF()
                    loc_lnAti = IIF(loc_lnVmt = 0, 0, IIF(EMPTY(loc_lnVmt), 100, (loc_lnVvd * 100) / loc_lnVmt))
                    REPLACE &loc_lcCol. WITH loc_lnAti IN cursor_4c_Impressao
                ENDIF

                SELECT crSintetico
                LOCATE FOR CodVens = crVends.CodVens
                SCAN WHILE CodVens = crVends.CodVens
                    loc_ldDat = crSintetico.Datas
                    SELECT cursor_4c_Impressao
                    GO TOP
                    LOCATE FOR Datas = PADR(DTOC(loc_ldDat), 10)
                    IF !EOF()
                        REPLACE &loc_lcCol. WITH &loc_lcCol. + crSintetico.ValVdaCom ;
                            IN cursor_4c_Impressao
                    ENDIF
                    SELECT crSintetico
                ENDSCAN
            ENDSCAN

            *-- Totaliza coluna TotalV
            UPDATE cursor_4c_Impressao ;
               SET TotalV = V01 + V02 + V03 + V04 + V05 + V06 + V07 + V08 + ;
                            V09 + V10 + V11 + V12 + V13 ;
             WHERE !Datas = "ATINGIDO  "

            *-- Corrige total da meta da empresa
            loc_lnVmt = LocalCmCab.MetaEmps
            loc_lnVvd = 0
            SELECT cursor_4c_Impressao
            GO TOP
            LOCATE FOR Datas = "VENDAS    "
            IF !EOF()
                loc_lnVvd = cursor_4c_Impressao.TotalV
            ENDIF

            SELECT cursor_4c_Impressao
            GO TOP
            LOCATE FOR Datas = "METAS     "
            IF !EOF()
                REPLACE TotalV WITH loc_lnVmt IN cursor_4c_Impressao
            ENDIF

            SELECT cursor_4c_Impressao
            GO TOP
            LOCATE FOR Datas = "ATINGIDO  "
            IF !EOF()
                loc_lnAti = IIF(loc_lnVmt = 0, 0, IIF(EMPTY(loc_lnVmt), 100, (loc_lnVvd * 100) / loc_lnVmt))
                REPLACE TotalV WITH loc_lnAti IN cursor_4c_Impressao
            ENDIF

            SELECT cursor_4c_Cabecalho
            GO TOP
            SELECT cursor_4c_Impressao
            GO TOP

            *-- Limpa cursores temporarios de SQL
            IF USED("LocalCmCab")
                USE IN LocalCmCab
            ENDIF
            IF USED("LocalVendas")
                USE IN LocalVendas
            ENDIF
            IF USED("LocalEdns")
                USE IN LocalEdns
            ENDIF
            IF USED("LocalCmPro")
                USE IN LocalCmPro
            ENDIF
            IF USED("LocalCmFxa")
                USE IN LocalCmFxa
            ENDIF
            IF USED("LocalCmVen")
                USE IN LocalCmVen
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara cursor_4c_Excel para exportacao
    * Equivalente ao PROCEDURE documentoexcel do original
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Excel
            ZAP

            SET POINT TO ","
            SET SEPARATOR TO "."

            SELECT cursor_4c_Impressao
            SCAN
                INSERT INTO cursor_4c_Excel ;
                    (V01, V02, V03, V04, V05, V06, V07, V08, V09, V10, V11, V12, V13, TotalV, Datas) ;
                    VALUES ( ;
                        TRANSFORM(cursor_4c_Impressao.V01, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V02, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V03, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V04, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V05, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V06, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V07, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V08, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V09, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V10, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V11, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V12, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.V13, "999999999.99"), ;
                        TRANSFORM(cursor_4c_Impressao.TotalV, "999999999.99"), ;
                        cursor_4c_Impressao.Datas)
            ENDSCAN

            SET POINT TO "."
            SET SEPARATOR TO ","

            SELECT cursor_4c_Excel
            GO TOP

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o relatorio para impressora
    * Equivalente ao PROCEDURE impressao do original
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_oErro, loc_cFrx
        loc_lResultado = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF

            loc_cFrx = gc_4c_CaminhoBase + "reports\SigReCmm.frx"
            IF !FILE(loc_cFrx)
                THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                                          "o encontrado: " + loc_cFrx
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lResultado = .F.
            ENDIF

            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe o relatorio em preview na tela
    * Equivalente ao PROCEDURE visualizacao do original
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_oErro, loc_cFrx
        loc_lResultado = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lResultado = .F.
            ENDIF

            loc_cFrx = gc_4c_CaminhoBase + "reports\SigReCmm.frx"
            IF !FILE(loc_cFrx)
                THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                                          "o encontrado: " + loc_cFrx
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lResultado = .F.
            ENDIF

            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "MAPA=" + ALLTRIM(THIS.this_cCodMapa) + ;
                     ";VEN=" + ALLTRIM(THIS.this_cCodVens)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Para BO de relatorio, o cursor pode armazenar parametros previamente usados
    * par_cAliasCursor: nome do cursor com colunas dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.cCodMapa") = "C"
                        THIS.this_cCodMapa = ALLTRIM(m.cCodMapa)
                    ENDIF
                    IF TYPE("m.cCodVens") = "C"
                        THIS.this_cCodVens = ALLTRIM(m.cCodVens)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        LOCAL loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF
            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCmm") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.FecharCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE
