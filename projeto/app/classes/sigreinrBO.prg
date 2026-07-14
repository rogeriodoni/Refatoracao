*==============================================================================
* SIGREINRBO.PRG
* Business Object para Relatorio de Inventario (SIGREINR)
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS sigreinrBO AS RelatorioBase

    this_nNumBal         = 0
    this_nTipoRel        = 1

    *-- Tipo diferenca: 1=Todos, 2=Com Diferenca
    this_nTipoDif        = 2

    *-- Tipo leitura: 1=Leitura, 2=Releitura
    this_nTipoLeitura    = 1

    *-- Tipo analitico: 1=Produto, 2=Local, 3=Etiqueta/Barras
    this_nTipoAnal       = 1

    this_cProduto        = ""
    this_cDsProduto      = ""
    this_cLocal          = ""
    this_cDsLocal        = ""
    this_nBarra          = 0

    *-- Opcoes de impressao (1=Sim 2=Nao)
    this_nOptTpCusto     = 2
    this_nOptTpVenda     = 1
    this_nOptFoto        = 2
    this_nOptEtiq        = 2
    this_nOptObs         = 2
    this_nOptCtg         = 2
    this_nOptCol         = 2

    this_lTrataPeso      = .F.
    this_cEmpresa        = ""
    this_cTitulo         = ""
    this_lHorizontal     = .F.
    this_nTotalLido      = 0
    this_nTotalEsto      = 0
    this_nSaldo          = 0
    this_nSaldoPs        = 0

    *-- CsRelatorio: nome do cursor de saida (referenciado pelos FRX legados)
    this_cCursorDados    = "CsRelatorio"

    *-- Controle de acesso (setado pelo Form via fChecaAcesso)
    this_lBalcTrats      = .F.
    this_lPermissaoCusto     = .F.
    this_lPermissaoRelatorio = .T.

    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDadosBasicos - Carrega cursores SQL necessarios para o form
    * Chamado por Form.InicializarForm() com o numero do balanco
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDadosBasicos(par_nNumBal)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_oErro
        LOCAL lcEmpr, loc_cTmp
        loc_lSucesso = .F.

        THIS.this_nNumBal = par_nNumBal

        TRY
            lcEmpr = go_4c_Sistema.cCodEmpresa

            *-- CsFiltro
            IF USED("CsFiltro")
                USE IN CsFiltro
            ENDIF
            CREATE CURSOR CsFiltro (FGrupo c(50), FEstoque c(80), FPeriodo c(60), ;
                FLocal c(60), FIFor c(60), FCGru c(60), FCGGru c(60), FPreco c(60), ;
                CObs M, llVisCtg l, llVisCol l)

            *-- CsSigCdPam
            IF USED("CsSigCdPam")
                USE IN CsSigCdPam
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "Select BalcTrats From SigCdPam", ;
                "cursor_4c_PamTmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsSigCdPam)"
                loc_lSucesso = .F.
            ENDIF
            SELECT * FROM cursor_4c_PamTmp INTO CURSOR CsSigCdPam READWRITE
            USE IN cursor_4c_PamTmp
            SELECT CsSigCdPam
            GO TOP
            IF !EOF()
                IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                    THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                ELSE
                    IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                        THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                    ELSE
                        IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                            THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                        ELSE
                            IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                            ELSE
                                IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                    THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                ELSE
                                    IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                        THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                    ELSE
                                        IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                            THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                        ELSE
                                            IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                            ELSE
                                                IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                    THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                ELSE
                                                    IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                        THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                    ELSE
                                                        IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                            THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                        ELSE
                                                            IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                            ELSE
                                                                IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                    THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                ELSE
                                                                    IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                        THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                    ELSE
                                                                        IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                            THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                        ELSE
                                                                            IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                            ELSE
                                                                                IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                    THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                ELSE
                                                                                    IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                        THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                    ELSE
                                                                                        IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                            THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                        ELSE
                                                                                            IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                            ELSE
                                                                                                IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                    THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                                ELSE
                                                                                                    IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                        THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                                    ELSE
                                                                                                        IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                            THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                                        ELSE
                                                                                                            IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                                THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                                            ELSE
                                                                                                                IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                                    THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                                        THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                                            THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                                                THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                                                                                                                    THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                                                                                                                                ELSE
                                                                                                                                    THIS.this_lBalcTrats = (NVL(CsSigCdPam.BalcTrats, 0) = 1)
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- CsSigCdBal
            IF USED("CsSigCdBal")
                USE IN CsSigCdBal
            ENDIF
            loc_cSQL = "Select * From SigCdBal Where Emps = ?lcEmpr And Codigos = ?par_nNumBal"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BalTmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsSigCdBal)"
                loc_lSucesso = .F.
            ENDIF
            SELECT * FROM cursor_4c_BalTmp INTO CURSOR CsSigCdBal READWRITE
            USE IN cursor_4c_BalTmp

            *-- CrSigCdEmp
            IF USED("CrSigCdEmp")
                USE IN CrSigCdEmp
            ENDIF
            loc_cSQL = "Select CEmps,Razas From SigCdEmp Where CEmps = ?lcEmpr"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdEmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CrSigCdEmp)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdEmp
            GO TOP
            IF !EOF()
                THIS.this_cEmpresa = ALLTRIM(CrSigCdEmp.CEmps) + ;
                    IIF(!EMPTY(CrSigCdEmp.Razas), " - " + ALLTRIM(CrSigCdEmp.Razas), "")
            ENDIF

            *-- CrSigCdGcr
            IF USED("CrSigCdGcr")
                USE IN CrSigCdGcr
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "Select Codigos,Descrs From SigCdGcr", "CrSigCdGcr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CrSigCdGcr)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdGcr
            INDEX ON Codigos TAG Codigos
            GO TOP

            *-- CsOperacaos - grid de ocorrencias (TipoRel=4), precisa ser READWRITE
            IF USED("CsOperacaos")
                USE IN CsOperacaos
            ENDIF
            loc_cSQL = [Select 0 As Marcas,Codigos,Descrs From SigBaOco Where Tipos = 'O' Order By Codigos]
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeTmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsOperacaos)"
                loc_lSucesso = .F.
            ENDIF
            SELECT * FROM cursor_4c_OpeTmp INTO CURSOR CsOperacaos READWRITE
            USE IN cursor_4c_OpeTmp
            SELECT CsOperacaos
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            IF !USED("CsOperacaos")
                CREATE CURSOR CsOperacaos (Marcas n(1), Codigos c(10), Descrs c(50))
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados conforme tipo de relatorio
    * Equivalente ao PROCEDURE processamento do legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_oErro
        LOCAL lnNumBal, lcEmpr, lnTpCusto, lnTpVenda
        LOCAL lnDecimals, lcFixed, lcEscape, lcTalk
        LOCAL lcDsGrupo, lcDsConta, lcDataInis, lcDataFims
        LOCAL llImpObs, llMostraCtg, llMostraCol, lnTcLinhas
        LOCAL lcpro, lcSql, lcBarra, lcCampoTc, lcCodigo, lcDirectory, lcFoto
        LOCAL lnValor, lnValPesos, lnCusto, lnRegs, lnRega, llOk
        LOCAL lcpros_val, lnbarra_val, lclocal_val, lnTipoL1, lnTipoL3
        LOCAL lcpro_prev, lnBarra_prev
        loc_lSucesso = .F.

        TRY
            lnNumBal    = THIS.this_nNumBal
            lcEmpr      = go_4c_Sistema.cCodEmpresa
            lnTpCusto   = THIS.this_nOptTpCusto
            lnTpVenda   = THIS.this_nOptTpVenda
            llImpObs    = (THIS.this_nOptObs = 1)
            llMostraCtg = (THIS.this_nOptCtg = 1)
            llMostraCol = (THIS.this_nOptCol = 1)
            THIS.this_lHorizontal = .F.

            *-- Garante CsSigCdBal carregado
            IF !USED("CsSigCdBal")
                loc_cSQL = "Select * From SigCdBal Where Emps = ?lcEmpr And Codigos = ?lnNumBal"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BalTmp2")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsSigCdBal)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM cursor_4c_BalTmp2 INTO CURSOR CsSigCdBal READWRITE
                USE IN cursor_4c_BalTmp2
            ENDIF

            SELECT CsSigCdBal
            GO TOP
            SCATTER MEMVAR MEMO

            THIS.this_lTrataPeso = (m.trtporpeso = 1)

            *-- Descricao do grupo
            lcDsGrupo = ""
            IF USED("CrSigCdGcr") AND !EMPTY(m.Grupos)
                IF SEEK(m.Grupos, "CrSigCdGcr", "Codigos")
                    lcDsGrupo = ALLTRIM(CrSigCdGcr.descrs)
                ENDIF
            ENDIF

            *-- Descricao da conta/estoque
            lcDsConta = ""
            IF !EMPTY(m.Contas)
                LOCAL lccontas_val
                lccontas_val = ALLTRIM(m.Contas)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "Select iclis,rclis From SigCdCli Where iclis = ?lccontas_val", "TmpCli")
                IF loc_nResult > 0
                    SELECT TmpCli
                    GO TOP
                    IF !EOF()
                        lcDsConta = ALLTRIM(TmpCli.RClis)
                    ENDIF
                    USE IN TmpCli
                ENDIF
            ENDIF

            *-- Monta cabecalho de filtros
            lcDataInis  = IIF(EMPTY(m.DataInis), "", DTOC(m.DataInis))
            lcDataFims  = IIF(EMPTY(m.DataFims), "", DTOC(m.DataFims))
            m.FGrupo    = IIF(!EMPTY(m.Grupos),  "     Grupo: " + ALLTRIM(m.Grupos) + IIF(!EMPTY(lcDsGrupo), " - " + lcDsGrupo, ""), "")
            m.FEstoque  = IIF(!EMPTY(m.Contas),  "   Estoque: " + ALLTRIM(m.Contas) + IIF(!EMPTY(lcDsConta), " - " + lcDsConta, ""), "")
            m.FPeriodo  = IIF(!EMPTY(lcDataInis + lcDataFims), "   Periodo: " + lcDataInis + " - " + lcDataFims, "")
            m.FLocal    = IIF(!EMPTY(m.LocalIs + m.LocalFs),  "     Local: " + m.LocalIs + " - " + m.LocalFs, "")
            m.FIFor     = IIF(!EMPTY(m.IForIs + m.IForFs),   "Fornecedor: " + m.IForIs + " - " + m.IForFs, "")
            m.FCGru     = IIF(!EMPTY(m.CGruIs + m.CGruFs),   "     Grupo: " + m.CGruIs + " - " + m.CGruFs, "")
            m.FCGGru    = IIF(!EMPTY(m.CGGruIs + m.CGGruFs), "Gde. Grupo: " + m.CGGruIs + " - " + m.CGGruFs, "")
            m.FPreco    = IIF(m.PrecoIs + m.PrecoFs > 0, "     Pre" + CHR(231) + "o: " + ;
                STR(m.PrecoIs, 9, 2) + " - " + STR(m.PrecoFs, 9, 2), "")
            m.CObs      = ""
            m.llVisCtg  = llMostraCtg
            m.llVisCol  = llMostraCol

            IF llImpObs
                m.CObs = IIF(EMPTY(m.Obs), "", "Observa" + CHR(231) + CHR(227) + "o: " + ALLTRIM(m.Obs))
            ENDIF

            IF USED("CsFiltro")
                SELECT CsFiltro
                INSERT INTO CsFiltro FROM MEMVAR
            ENDIF

            IF USED("CrSMoeda")
                USE IN CrSMoeda
            ENDIF
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            DO CASE

            *==================================================================
            CASE THIS.this_nTipoRel = 1

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio Resumido do Invent" + CHR(225) + "rio n" + ;
                    CHR(186) + " " + ALLTRIM(STR(lnNumBal)) + " - " + ;
                    IIF(THIS.this_nTipoDif = 1, "Todos", "Com Diferen" + CHR(231) + "a")

                lnDecimals = SET("Decimals")
                lcFixed    = SET("Fixed")
                lcEscape   = SET("Escape")
                lcTalk     = SET("Talk")

                SET ESCAPE OFF
                SET TALK ON
                SET DECIMALS TO 2
                SET FIXED ON

                WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT

                loc_cSQL = [Select a.*,b.CustoFs,b.MoeCusFs,b.PVens As PPVens,b.Moevs,b.FVendas,b.MoePVs,b.Linhas,b.Reffs, ] + ;
                    [ltrim(rtrim(isnull(b.Colecoes,'')))+'-'+ltrim(rtrim(isnull(d.descs,''))) as Colecoes,] + ;
                    [ltrim(rtrim(isnull(b.Categoria,'')))+'-' +ltrim(rtrim(isnull(e.descs,''))) as Categoria,] + ;
                    [b.PesoMs,Space(200) as Obs, c.TpCustos As TpCus ]

                IF THIS.this_nOptFoto = 1
                    loc_cSQL = loc_cSQL + [, b.dPros, b.FigJpgs ]
                ENDIF

                loc_cSQL = loc_cSQL + ;
                    [From SigIvTrB a, SigCdPro b ] + ;
                    [Left Join SigCdLin c On c.Linhas = b.Linhas ] + ;
                    [left Join sigcdctg e on b.categoria = e.cods ] + ;
                    [left Join SigCdCol d on b.Colecoes = d.colecoes ] + ;
                    [Where a.Emps = ?lcEmpr And a.Codigos = ?lnNumBal And b.CPros = a.CPros ] + ;
                    [Order By a.CIdChaves ]

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BaseTmp") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (Base)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM cursor_4c_BaseTmp INTO CURSOR Base READWRITE
                USE IN cursor_4c_BaseTmp

                SELECT Base
                GO TOP
                INDEX ON CPros + CodCors + CodTams + Contas TAG CPros
                REPLACE ALL Lidos WITH 0, ReLidos WITH 0, Lidops WITH 0, ReLidops WITH 0

                lcSql = [Select CPros, CodCors, CodTams, Contas, CBars, Tipos, Qtds, Pesos, PesReals, ] + ;
                    [IsNull(Obs, Space(200)) as Obs ] + ;
                    [From SigIvTrH ] + ;
                    [Where Codigos = ?lnNumBal And Emps = ?lcEmpr Order By CIdChaves ]

                IF SQLEXEC(gnConnHandle, lcSql, "crTmpHist") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (crTmpHist)"
                    loc_lSucesso = .F.
                ENDIF

                SELECT crTmpHist
                WAIT WINDOW "Aguarde!!! Processando Produtos Lidos/Relidos..." NOWAIT
                SCAN
                    IF !SEEK(crTmpHist.CPros + crTmpHist.CodCors + crTmpHist.CodTams + ;
                        crTmpHist.Contas, "Base", "CPros")
                        INSERT INTO Base (CPros, CodCors, CodTams, Contas, Emps, Codigos, Obs) ;
                            VALUES (crTmpHist.CPros, crTmpHist.CodCors, crTmpHist.CodTams, ;
                                crTmpHist.Contas, lcEmpr, lnNumBal, crTmpHist.Obs)
                    ELSE
                        REPLACE Obs WITH crTmpHist.Obs IN Base
                    ENDIF

                    llOk = .T.
                    IF !EMPTY(crTmpHist.CBars)
                        lnbarra_val = crTmpHist.CBars
                        lcSql = [Select * from SigIvTrE Where Cbars = ] + ;
                            STR(crTmpHist.CBars, 14) + [ And Codigos = ?lnNumBal ]
                        IF SQLEXEC(gnConnHandle, lcSql, "CrTmpEti") > 0
                            IF EOF("CrTmpEti")
                                IF SQLEXEC(gnConnHandle, ;
                                    "Select * From SigOpEtq Where CBars = ?lnbarra_val", "CsTmpEti") > 0
                                    IF EOF("CsTmpEti")
                                        IF SQLEXEC(gnConnHandle, ;
                                            "Select * From SigCdPro Where CBars = ?lnbarra_val", "CrTmpEti") > 0
                                            IF EOF("CrTmpEti")
                                                llOk = .F.
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    IF llOk
                        IF INLIST(crTmpHist.Tipos, 1, 3)
                            REPLACE Lidos  WITH Lidos  + crTmpHist.Qtds  IN Base
                            REPLACE Lidops WITH Lidops + crTmpHist.Pesos IN Base
                        ELSE
                            REPLACE ReLidos  WITH ReLidos  + crTmpHist.Qtds  IN Base
                            REPLACE ReLidops WITH ReLidops + crTmpHist.Pesos IN Base
                        ENDIF
                    ENDIF

                    SELECT crTmpHist
                ENDSCAN
                WAIT CLEAR

                SELECT Base
                GO TOP

                SELECT a.*, ;
                    VAL(STR(a.PPVens * (a.Saldos - IIF(EMPTY(a.ReLidos), a.Lidos, a.ReLidos)), 16, 2)) AS PVens, ;
                    VAL(STR(a.PPVens * (a.Saldops - IIF(EMPTY(a.ReLidops), a.Lidops, a.ReLidops)), 16, 2)) AS PVenPesos, ;
                    lnTpCusto AS TpCustos, lnTpVenda AS TpVendas, ;
                    Space(200) AS TcCabecs, Space(200) AS TcTraco1s, ;
                    Space(200) AS TcLinhas, Space(200) AS TcLinhas1, Space(200) AS TcLinhas2, ;
                    Space(200) AS TcLinhas3, Space(200) AS TcLinhas4, ;
                    "1" AS Ps, Space(11) AS OrdImg ;
                FROM Base a ;
                ORDER BY a.Contas, a.CPros, a.CodCors, a.CodTams ;
                INTO CURSOR CsBase READWRITE

                WAIT WINDOW "Aguarde! Calculando Custos..." NOWAIT

                lnTcLinhas = 1

                SELECT * FROM CsBase INTO CURSOR CsRelatorio READWRITE
                SELECT CsRelatorio
                GO TOP
                SCAN
                    lnCusto = CsRelatorio.CustoFs
                    IF NVL(CsRelatorio.TpCus, "") = "2"
                        lnCusto = CsRelatorio.PesoMs * CsRelatorio.CustoFs
                    ENDIF
                    REPLACE CsRelatorio.CustoFs WITH ;
                        lnCusto * (CsRelatorio.Saldos - IIF(EMPTY(CsRelatorio.ReLidos), ;
                        CsRelatorio.Lidos, CsRelatorio.ReLidos))

                    IF THIS.this_nOptFoto = 1
                        IF EMPTY(CsRelatorio.FigJpgs) OR ISNULL(CsRelatorio.FigJpgs)
                            REPLACE OrdImg WITH "FBRANCOS" IN CsRelatorio
                        ELSE
                            lcCodigo    = ALLTRIM(CsRelatorio.cPros)
                            lcCodigo    = STRTRAN(lcCodigo, "/", "")
                            lcCodigo    = STRTRAN(lcCodigo, " ", "")
                            lcDirectory = SYS(2023) + "\F" + ALLTRIM(lcCodigo) + ".Jpg"
                            REPLACE OrdImg WITH "F" + ALLTRIM(lcCodigo) IN CsRelatorio
                            lcFoto = STRTRAN(STRTRAN(STRTRAN(CsRelatorio.FigJpgs, ;
                                "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                                "data:image/jpg;base64,", "")
                            STRTOFILE(STRCONV(lcFoto, 14), lcDirectory)
                        ENDIF
                    ENDIF

                    IF THIS.this_nOptEtiq = 1
                        lcpros_val = CsRelatorio.cPros
                        IF (IIF(EMPTY(CsRelatorio.ReLidos), CsRelatorio.Lidos, CsRelatorio.ReLidos) > ;
                            CsRelatorio.Saldos) OR ;
                            (IIF(EMPTY(CsRelatorio.ReLidops), CsRelatorio.Lidops, CsRelatorio.ReLidops) > ;
                            CsRelatorio.Saldops)
                            lcSql = [Select cBars from SigIvTrH Where cPros = '] + lcpros_val + ;
                                [' And Codigos = ] + STR(lnNumBal) + ;
                                [ And not cBars in (Select cBars from SigIvTre Where cPros = '] + ;
                                lcpros_val + [' And Codigos = ] + STR(lnNumBal) + [)]
                        ELSE
                            lcSql = [Select cBars from SigIvTrE Where cPros = '] + lcpros_val + ;
                                [' And Codigos = ] + STR(lnNumBal) + ;
                                [ And not cBars in (Select cBars from SigIvTrH Where cPros = '] + ;
                                lcpros_val + [' And Codigos = ] + STR(lnNumBal) + [)]
                        ENDIF
                        SQLEXEC(gnConnHandle, lcSql, "crBarras")
                        SELECT crBarras
                        GO TOP
                        SCAN
                            SELECT CsRelatorio
                            IF THIS.this_nOptFoto = 1
                                lcCampoTc = "TcLinhas" + STR(lnTcLinhas, 1)
                                lcBarra = ALLTRIM(STR(crBarras.cBars, 14)) + ", "
                                IF lnTcLinhas < 5
                                    IF LEN(ALLTRIM(&lcCampoTc)) + LEN(lcBarra) > 146
                                        lnTcLinhas = lnTcLinhas + 1
                                        lcCampoTc = "TcLinhas" + STR(lnTcLinhas, 1)
                                    ENDIF
                                    REPLACE &lcCampoTc WITH ALLTRIM(&lcCampoTc) + lcBarra
                                ENDIF
                            ENDIF
                            SELECT crBarras
                        ENDSCAN
                        SELECT CsRelatorio
                    ENDIF
                ENDSCAN

                *-- Totais por moeda
                SELECT a.Moecusfs AS Moedas, ;
                    VAL(STR(SUM(a.CustoFs), 16, 2)) AS CustoFs, ;
                    0000000000000000.00 AS PVens, ;
                    0000000000000000.00 AS PVenPesos ;
                FROM CsBase a ;
                WHERE lnTpCusto = 1 ;
                GROUP BY a.Moecusfs ;
                UNION ALL ;
                SELECT a.MoeVs AS Moedas, ;
                    0000000000000000.00 AS CustoFs, ;
                    VAL(STR(SUM(a.PVens), 16, 2)) AS PVens, ;
                    VAL(STR(SUM(a.PVenPesos), 16, 2)) AS PVenPesos ;
                FROM CsBase a ;
                WHERE lnTpVenda = 1 ;
                GROUP BY a.MoeVs ;
                ORDER BY 1 ;
                INTO CURSOR crSMoeda READWRITE

                WAIT WINDOW "Aguarde! Finalizando o processamento..." NOWAIT

                SELECT CsRelatorio
                INDEX ON Ps + Contas + CPros + CodCors + CodTams TAG Chave1
                SET ORDER TO "" IN CsRelatorio
                GO TOP

                SCAN
                    m.TcCabecs = PADR(PADC("Produto", IIF(THIS.this_nOptFoto = 1, 41, 14)) + " " + ;
                        PADC("Cor/Tam", 09) + " " + ;
                        PADC("Apurado", 10) + " " + ;
                        PADC("Estoque", 11) + " " + ;
                        PADC("Sobra", 10) + " " + ;
                        PADC("Falta", 10) + " " + ;
                        IIF(llMostraCtg, PADC("Colecoes", 30) + " ", "") + ;
                        IIF(llMostraCol, PADC("Categoria", 20) + " ", "") + ;
                        IIF(CsRelatorio.TpCustos = 1, PADC("Pre" + CHR(231) + "o Custo", 14) + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, PADC("Pre" + CHR(231) + "o Venda", 14) + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, PADC("Fator Venda", 14) + " ", "") + ;
                        IIF(THIS.this_lTrataPeso, PADC("Peso Apur", 9) + " " + ;
                            PADC("Peso Estq", 9) + " " + ;
                            PADC("Sobra", 10) + " " + ;
                            PADC("Falta", 10), "") + " " + ;
                        PADC("Observa" + CHR(231) + CHR(227) + "o", 10), 220)

                    m.TcTraco1s = PADR(REPLICATE("_", IIF(THIS.this_nOptFoto = 1, 41, 14)) + " " + ;
                        REPLICATE("_", 09) + " " + ;
                        REPLICATE("_", 10) + " " + ;
                        REPLICATE("_", 11) + " " + ;
                        REPLICATE("_", 10) + " " + ;
                        REPLICATE("_", 10) + " " + ;
                        IIF(llMostraCtg, REPLICATE("_", 30) + " ", "") + ;
                        IIF(llMostraCol, REPLICATE("_", 20) + " ", "") + ;
                        IIF(CsRelatorio.TpCustos = 1, REPLICATE("_", 14) + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, REPLICATE("_", 14) + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, REPLICATE("_", 14) + " ", "") + ;
                        IIF(THIS.this_lTrataPeso, REPLICATE("_", 9) + " " + ;
                            REPLICATE("_", 9) + " " + ;
                            REPLICATE("_", 10) + " " + ;
                            REPLICATE("_", 10), "") + " " + ;
                        REPLICATE("_", 10), 220)

                    lnValor    = CsRelatorio.Saldos - ;
                        IIF(EMPTY(CsRelatorio.ReLidos), CsRelatorio.Lidos, CsRelatorio.ReLidos)
                    lnValPesos = CsRelatorio.Saldops - ;
                        IIF(EMPTY(CsRelatorio.ReLidops), CsRelatorio.Lidops, CsRelatorio.ReLidops)

                    SET DECIMALS TO 3

                    m.TcLinhas = PADR(PADR(CsRelatorio.CPros, 14) + " " + ;
                        IIF(THIS.this_nOptFoto = 1, PADR(CsRelatorio.DPros, 25) + " ", "") + ;
                        CsRelatorio.CodCors + "/" + CsRelatorio.CodTams + " " + ;
                        TRANSFORM(IIF(EMPTY(CsRelatorio.ReLidos), CsRelatorio.Lidos, ;
                            CsRelatorio.ReLidos), "999999.999") + " " + ;
                        TRANSFORM(CsRelatorio.Saldos, "9999999.999") + " " + ;
                        TRANSFORM(IIF(lnValor < 0, ABS(lnValor), 0), "@Z 999999.999") + " " + ;
                        TRANSFORM(IIF(lnValor > 0, ABS(lnValor), 0), "@Z 999999.999") + " " + ;
                        IIF(llMostraCtg, PADR(CsRelatorio.Categoria, 30) + " ", "") + ;
                        IIF(llMostraCol, PADR(CsRelatorio.Colecoes, 20) + " ", "") + ;
                        IIF(CsRelatorio.TpCustos = 1, ;
                            TRANSFORM(CsRelatorio.CustoFs, "99999999.99") + " ", "") + ;
                        IIF(CsRelatorio.TpCustos = 1, PADR(CsRelatorio.MoeCusFs, 3), "") + ;
                        IIF(CsRelatorio.TpVendas = 1, ;
                            TRANSFORM(CsRelatorio.PVens, "99999999.99") + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, PADR(CsRelatorio.MoeVs, 3), "") + ;
                        IIF(CsRelatorio.TpVendas = 1, ;
                            TRANSFORM(CsRelatorio.FVendas, "@Z 99999999.99") + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, PADR(CsRelatorio.MoePVs, 3), "") + ;
                        IIF(THIS.this_lTrataPeso, ;
                            TRANSFORM(IIF(EMPTY(CsRelatorio.ReLidops), CsRelatorio.Lidops, ;
                                CsRelatorio.ReLidops), " 9999.999") + " " + ;
                            TRANSFORM(CsRelatorio.Saldops, " 9999.999") + " " + ;
                            TRANSFORM(IIF(lnValPesos < 0, ABS(lnValPesos), 0), "@Z   9999.999") + " " + ;
                            TRANSFORM(IIF(lnValPesos > 0, ABS(lnValPesos), 0), "@Z   9999.999"), "") + ;
                        " " + ALLTRIM(CsRelatorio.Obs), 220)

                    GATHER MEMVAR FIELDS TcCabecs, TcTraco1s, TcLinhas

                    IF LEN(ALLTRIM(m.TcCabecs)) > 120
                        THIS.this_lHorizontal = .T.
                    ENDIF
                    IF !EMPTY(ALLTRIM(CsRelatorio.Obs))
                        THIS.this_lHorizontal = .T.
                    ENDIF

                    SET DECIMALS TO 2
                ENDSCAN

                *-- Etiquetas sem foto
                IF THIS.this_nOptFoto <> 1 AND THIS.this_nOptEtiq = 1
                    SELECT CsRelatorio
                    lnRegs = RECCOUNT()
                    lnRega = 1
                    GO TOP
                    DO WHILE lnRegs >= lnRega
                        lcpros_val = CsRelatorio.cPros
                        IF (IIF(EMPTY(CsRelatorio.ReLidos), CsRelatorio.Lidos, CsRelatorio.ReLidos) > ;
                            CsRelatorio.Saldos) OR ;
                            (IIF(EMPTY(CsRelatorio.ReLidops), CsRelatorio.Lidops, CsRelatorio.ReLidops) > ;
                            CsRelatorio.Saldops)
                            lcSql = [Select cBars from SigIvTrH Where cPros = '] + lcpros_val + ;
                                [' And Codigos = ] + STR(lnNumBal) + ;
                                [ And not cBars in (Select cBars from SigIvTre Where cPros = '] + ;
                                lcpros_val + [' And Codigos = ] + STR(lnNumBal) + [)]
                        ELSE
                            lcSql = [Select cBars from SigIvTrE Where cPros = '] + lcpros_val + ;
                                [' And Codigos = ] + STR(lnNumBal) + ;
                                [ And not cBars in (Select cBars from SigIvTrH Where cPros = '] + ;
                                lcpros_val + [' And Codigos = ] + STR(lnNumBal) + [)]
                        ENDIF
                        SQLEXEC(gnConnHandle, lcSql, "crBarras")
                        SELECT crBarras
                        GO TOP
                        IF !EOF()
                            SELECT CsRelatorio
                            SCATTER MEMVAR
                            m.TcLinhas = ""
                            SELECT crBarras
                            SCAN
                                lcBarra = ALLTRIM(STR(crBarras.cBars, 14)) + ", "
                                IF LEN(m.TcLinhas) + LEN(lcBarra) > 114
                                    SELECT CsRelatorio
                                    APPEND BLANK
                                    GATHER MEMVAR
                                    m.TcLinhas = ""
                                ENDIF
                                m.TcLinhas = m.TcLinhas + lcBarra
                                SELECT crBarras
                            ENDSCAN
                            SELECT CsRelatorio
                            APPEND BLANK
                            GATHER MEMVAR
                        ENDIF
                        SELECT CsRelatorio
                        GO lnRega
                        SKIP
                        lnRega = lnRega + 1
                    ENDDO
                ENDIF

                *-- Totais consolidados por moeda
                SELECT CrSMoeda
                GO TOP
                SELECT Moedas, SUM(CustoFs) AS CustoFs, SUM(PVens) AS PVens, ;
                    SUM(PVenPesos) AS PVenPesos ;
                FROM crSMoeda ;
                GROUP BY Moedas ;
                INTO CURSOR TmpMoeda READWRITE

                SELECT TmpMoeda
                GO TOP
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO CsRelatorio (TcCabecs, TcTraco1s, TcLinhas, Ps) ;
                        VALUES (PADC(PADC("Moeda", 5) + " " + ;
                            IIF(lnTpCusto = 1, PADC("Pre" + CHR(231) + "o de Custo", 17) + " ", "") + ;
                            IIF(lnTpVenda = 1, PADC("Pre" + CHR(231) + "o Venda", 17) + " ", ""), 115), ;
                            PADC(REPLICATE("_", 5) + " " + ;
                            IIF(lnTpCusto = 1, REPLICATE("_", 17) + " ", "") + ;
                            IIF(lnTpVenda = 1, REPLICATE("_", 17) + " ", ""), 115), ;
                            PADC(PADR(m.Moedas, 6) + ;
                            IIF(lnTpCusto = 1, TRANSFORM(m.CustoFs, "99,999,999,999.99") + " ", "") + ;
                            IIF(lnTpVenda = 1, TRANSFORM(m.PVens, "99,999,999,999.99") + " ", ""), 115), ;
                            "2")
                    SELECT TmpMoeda
                ENDSCAN

                SET ESCAPE &lcEscape.
                SET TALK &lcTalk.
                SET DECIMALS TO lnDecimals
                SET FIXED &lcFixed.

                WAIT CLEAR

            *==================================================================
            CASE THIS.this_nTipoRel = 2

                WAIT WINDOW "Aguarde! Verificando Saldo..." NOWAIT
                THIS.this_nSaldo   = 0
                THIS.this_nSaldoPs = 0

                lcpros_val = THIS.this_cProduto
                loc_cSQL = [Select Emps,Codigos,CPros,Saldos,SaldoPs From SigIvTrB ] + ;
                    [Where Emps = ?lcEmpr And Codigos = ?lnNumBal And CPros = ?lcpros_val ] + ;
                    [Order By CIdChaves ]
                IF SQLEXEC(gnConnHandle, loc_cSQL, "Saldo") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (Saldo)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT Saldo
                GO TOP
                IF !EOF()
                    THIS.this_nSaldo   = Saldo.Saldos
                    THIS.this_nSaldoPs = Saldo.SaldoPs
                ENDIF

                WAIT WINDOW "Aguarde! Selecionando Hist" + CHR(243) + "ricos..." NOWAIT

                lnTipoL1   = THIS.this_nTipoLeitura
                lnTipoL3   = THIS.this_nTipoLeitura + 2
                lcpros_val = THIS.this_cProduto
                lclocal_val = THIS.this_cLocal
                lnbarra_val = THIS.this_nBarra

                loc_cSQL = [Select * From SigIvTrH ] + ;
                    [Where Emps = ?lcEmpr And Codigos = ?lnNumBal ]

                DO CASE
                    CASE THIS.this_nTipoAnal = 1
                        loc_cSQL = loc_cSQL + [And CPros = ?lcpros_val ]
                    CASE THIS.this_nTipoAnal = 2
                        loc_cSQL = loc_cSQL + [And Localis = ?lclocal_val ]
                    OTHERWISE
                        loc_cSQL = loc_cSQL + [And CBars = ] + ALLTRIM(STR(lnbarra_val, 14))
                ENDCASE

                loc_cSQL = loc_cSQL + [And (Tipos = ?lnTipoL1 Or Tipos = ?lnTipoL3) ] + ;
                    [Order By Tipos,CPros,CodCors,CodTams,Contas,Datas,CIdChaves ]

                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsRelatorio") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsRelatorio)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsRelatorio
                INDEX ON CBars TAG CBars
                GO TOP

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio Anal" + CHR(237) + "tico do Invent" + ;
                    CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal)) + " - " + ;
                    IIF(THIS.this_nTipoDif = 1, "Todos", "Com Diferen" + CHR(231) + "a")

                WAIT CLEAR

            *==================================================================
            CASE INLIST(THIS.this_nTipoRel, 3, 5, 8)

                WAIT WINDOW "Aguarde! Selecionando Etiquetas..." NOWAIT

                loc_cSQL = [Select a.*, IsNull(b.cbars_old,0) as cbars_old, c.localizas, Space(200) as Obs ] + ;
                    [From SigIvTrE a ] + ;
                    [left join SigOpEta b on a.cbars = b.cbars_new ] + ;
                    [left join SigOpEtq c on a.cbars = c.cbars ] + ;
                    [Where a.Emps = ?lcEmpr And a.Codigos = ?lnNumBal ] + ;
                    [Order By a.CPros,a.CBars,a.CIdChaves ]

                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsEtiqueta") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsEtiqueta)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsEtiqueta
                INDEX ON CBars TAG CBars
                GO TOP

                WAIT WINDOW "Aguarde! Selecionando Hist" + CHR(243) + "ricos..." NOWAIT

                loc_cSQL = [Select a.*, IsNull(b.cbars_old,0) as cbars_old, c.localizas ] + ;
                    [From SigIvTrH a ] + ;
                    [left join SigOpEta b on a.cbars = b.cbars_new ] + ;
                    [left join SigOpEtq c on a.cbars = c.cbars ] + ;
                    [Where a.Emps = ?lcEmpr And a.Codigos = ?lnNumBal ] + ;
                    [Order By a.CIdChaves ]

                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsHistorico") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsHistorico)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsHistorico
                INDEX ON CBars TAG CBars
                GO TOP

                CREATE CURSOR CsRelatorio (Emps c(3), Grupos c(10), Contas c(10), CBars n(14), ;
                    CPros c(14), Tipos c(20), Datas D, DPros c(70), Reffs c(40), ;
                    Colecoes c(50), Categoria c(50), pLocals c(10), cbars_old n(10), ;
                    CodTams c(3), Localizas c(10), Obs c(200))
                INDEX ON CBars TAG CBars
                INDEX ON Tipos + Contas + CPros + STR(CBars, 14) TAG TpProBar

                THIS.this_nTotalLido = 0
                THIS.this_nTotalEsto = 0

                WAIT CLEAR
                WAIT WINDOW "Verificando Etiquetas..." NOWAIT

                SELECT CsEtiqueta
                GO TOP
                SCAN
                    IF CsEtiqueta.CBars <> 0 AND !SEEK(CsEtiqueta.CBars, "CsHistorico", "CBars")
                        IF USED("TmpPro")
                            USE IN TmpPro
                        ENDIF
                        lcpros_val = CsEtiqueta.CPros
                        loc_cSQL = [Select a.CPros,a.DPros,a.Reffs,] + ;
                            [ltrim(rtrim(a.Colecoes))+'-'+ltrim(rtrim(b.descs)) as Colecoes, ] + ;
                            [ltrim(rtrim(a.Categoria))+'-' +ltrim(rtrim(c.descs)) as Categoria ] + ;
                            [From SigCdPro a ] + ;
                            [Join SigCdCol b on a.Colecoes = b.colecoes ] + ;
                            [Join SigCdCtg c on a.categoria = c.cods ] + ;
                            [Where CPros = ?lcpros_val ]
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpPro") < 1
                            THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (TmpPro)"
                            loc_lSucesso = .F.
                        ENDIF
                        SELECT TmpPro
                        GO TOP
                        INSERT INTO CsRelatorio (Emps, Grupos, Contas, CBars, CPros, Tipos, ;
                            Datas, DPros, Reffs, Categoria, Colecoes, pLocals, cbars_old, ;
                            CodTams, Localizas, Obs) ;
                            VALUES (CsEtiqueta.Emps, CsEtiqueta.Grupos, CsEtiqueta.Contas, ;
                                CsEtiqueta.CBars, CsEtiqueta.CPros, ;
                                "N" + CHR(227) + "o Lido", ;
                                NVL(CsEtiqueta.Datas, {}), TmpPro.DPros, TmpPro.Reffs, ;
                                TmpPro.Categoria, TmpPro.Colecoes, CsEtiqueta.Locals, ;
                                CsEtiqueta.cbars_old, CsEtiqueta.CodTams, ;
                                NVL(CsEtiqueta.localizas, ""), CsEtiqueta.Obs)
                        THIS.this_nTotalLido = THIS.this_nTotalLido + 1
                    ENDIF
                    SELECT CsEtiqueta
                ENDSCAN

                IF THIS.this_nTipoRel = 8
                    WAIT WINDOW "Verificando Hist" + CHR(243) + "ricos..." NOWAIT
                    SELECT CsHistorico
                    GO TOP
                    SCAN
                        IF CsHistorico.CBars <> 0 AND !SEEK(CsHistorico.CBars, "CsEtiqueta", "CBars") AND ;
                            !SEEK(CsHistorico.CBars, "CsRelatorio", "CBars")

                            lnbarra_val = CsHistorico.CBars
                            loc_cSQL = [Select Empos,Grupos,Contas From SigOpEtq Where Cbars = ] + ;
                                STR(CsHistorico.CBars, 14)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpProEtq") < 1
                                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (TmpProEtq)"
                                loc_lSucesso = .F.
                            ENDIF
                            SELECT TmpProEtq
                            GO TOP

                            lcpros_val = CsHistorico.CPros
                            loc_cSQL = [Select a.CPros,a.DPros,a.Reffs,] + ;
                                [ltrim(rtrim(a.Colecoes))+'-'+ltrim(rtrim(b.descs)) as Colecoes, ] + ;
                                [ltrim(rtrim(a.Categoria))+'-' +ltrim(rtrim(c.descs)) as Categoria ] + ;
                                [From SigCdPro a ] + ;
                                [Join SigCdCol b on a.Colecoes = b.colecoes ] + ;
                                [Join SigCdCtg c on a.categoria = c.cods ] + ;
                                [Where CPros = ?lcpros_val ]
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpPro") < 1
                                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (TmpPro)"
                                loc_lSucesso = .F.
                            ENDIF
                            SELECT TmpPro
                            GO TOP

                            INSERT INTO CsRelatorio (Emps, Grupos, Contas, CBars, CPros, Tipos, ;
                                Reffs, Categoria, Colecoes, pLocals, cbars_old, CodTams, Localizas) ;
                                VALUES (TmpProEtq.Empos, TmpProEtq.Grupos, TmpProEtq.Contas, ;
                                    CsHistorico.CBars, CsHistorico.CPros, ;
                                    "N" + CHR(227) + "o est" + CHR(225) + " no Estoque", ;
                                    TmpPro.Reffs, TmpPro.Categoria, TmpPro.Colecoes, ;
                                    CsHistorico.Locals, CsHistorico.cbars_old, ;
                                    CsHistorico.CodTams, NVL(CsHistorico.localizas, ""))
                            THIS.this_nTotalEsto = THIS.this_nTotalEsto + 1
                        ENDIF
                        SELECT CsHistorico
                    ENDSCAN
                ENDIF

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio de C" + CHR(243) + "digos de Barras do Invent" + ;
                    CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal)) + " - " + ;
                    IIF(THIS.this_nTipoDif = 1, "Todos", "Com Diferen" + CHR(231) + "a")

            *==================================================================
            CASE THIS.this_nTipoRel = 4

                WAIT WINDOW "Aguarde! Selecionando Hist" + CHR(243) + "ricos..." NOWAIT

                loc_cSQL = [Select * From SigIvTrH ] + ;
                    [Where Emps = ?lcEmpr And Codigos = ?lnNumBal Order By CIdChaves ]
                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsHistorico") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsHistorico)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsHistorico
                INDEX ON CBars TAG CBars
                GO TOP

                SELECT CsOperacaos
                GO TOP

                WAIT WINDOW "Aguarde! Selecionando Tratamentos..." NOWAIT

                loc_cSQL = [Select * From SigIvTrT Where Emps = ?lcEmpr And Codigos = ?lnNumBal Order By CIdChaves ]
                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsTratam") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsTratam)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsTratam
                GO TOP

                IF EOF()
                    SELECT a.* FROM CsHistorico a, CsOperacaos b ;
                        WHERE "O" + a.Ocors = "O" + b.Codigos AND b.Marcas = 1 ;
                        INTO CURSOR Selecao
                ELSE
                    SELECT a.Barras AS CBars, a.Ocorrencia AS Ocors, a.Obs, ;
                        a.PesReals, Space(10) AS Localis ;
                        FROM CsTratam a, CsOperacaos b ;
                        WHERE "O" + a.Ocorrencia = "O" + b.Codigos AND b.Marcas = 1 ;
                        INTO CURSOR Selecao
                ENDIF

                CREATE CURSOR CsRelatorio (CBars n(14), Ocors c(10), Obs m NULL, ;
                    PesReals n(9, 2), Localis c(10), Reffs c(40), ;
                    Categoria c(50), Colecoes c(50))
                INDEX ON Ocors + STR(CBars) TAG CBars

                WAIT CLEAR
                WAIT WINDOW "Verificando Ocorr" + CHR(234) + "ncias..." NOWAIT

                SELECT Selecao
                GO TOP
                SCAN
                    SCATTER MEMVAR MEMO
                    INSERT INTO CsRelatorio FROM MEMVAR
                    IF EMPTY(m.Localis)
                        = SEEK(Selecao.CBars, "CsHistorico", "CBars")
                        REPLACE CsRelatorio.Localis WITH CsHistorico.Localis
                    ENDIF
                    SELECT Selecao
                ENDSCAN
                WAIT CLEAR

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio de Ocorr" + CHR(234) + "ncias do Invent" + ;
                    CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal)) + " - " + ;
                    IIF(THIS.this_nTipoDif = 1, "Todos", "Com Diferen" + CHR(231) + "a")

            *==================================================================
            CASE THIS.this_nTipoRel = 6

                WAIT WINDOW "Aguarde! Selecionando Barras..." NOWAIT

                lcSql = [Select a.emps,a.cpros,a.cbars,a.codcors,b.cproeqs,b.dpros,b.pesometal, ] + ;
                    [b.pvens,c.cgrus,c.dcompos,c.qtds, b.tComps as primeiro, b.tcomps as Ultimo, b.Reffs, a.Pesos, ] + ;
                    [ltrim(rtrim(b.Colecoes))+'-'+ltrim(rtrim(d.descs)) as Colecoes,] + ;
                    [ltrim(rtrim(b.Categoria))+'-' +ltrim(rtrim(e.descs)) as Categoria ] + ;
                    [From SigIvTrE a ] + ;
                    [left Join SigCdPro b on a.cpros = b.cpros ] + ;
                    [left Join SigPrCpo c on a.cpros = c.cpros ] + ;
                    [left Join SigCdCol d on b.Colecoes = d.colecoes ] + ;
                    [left Join sigcdctg e on b.categoria = e.cods ] + ;
                    [Where a.Emps = '] + lcEmpr + [' And a.Codigos = ] + STR(lnNumBal) + [ ] + ;
                    [Order By a.cpros,a.cbars,c.cgrus ]

                IF SQLEXEC(gnConnHandle, lcSql, "cursor_4c_Barra6Tmp") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsRelatorio Tipo6)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM cursor_4c_Barra6Tmp INTO CURSOR CsRelatorio READWRITE
                USE IN cursor_4c_Barra6Tmp

                SELECT CsRelatorio
                INDEX ON Cpros + STR(CBars) + cGrus TAG Produto
                UPDATE CsRelatorio SET Primeiro = .F., Ultimo = .F., ;
                    cgrus = NVL(cgrus, " "), ;
                    Dcompos = NVL(dCompos, " "), ;
                    Qtds = NVL(Qtds, 0)

                SCAN
                    lcpro_prev   = cpros
                    lnBarra_prev = CBars
                    REPLACE Primeiro WITH .T.
                    SCAN WHILE Cpros = lcpro_prev AND CBars = lnBarra_prev
                    ENDSCAN
                    SKIP -1
                    REPLACE Ultimo WITH .T.
                ENDSCAN
                GO TOP

                WAIT CLEAR

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio C/Barra do Invent" + CHR(225) + ;
                    "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal))

            *==================================================================
            CASE THIS.this_nTipoRel = 7

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio de Estoque x Leitura do Invent" + ;
                    CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal))

                lcSql = [Select 'N] + CHR(227) + [o Lido - Falta   ' as Ps, d.Mercs, d.CGrus, ] + ;
                    [e.CPros, e.CBars, e.CodCors, e.CodTams, d.Dpros, ] + ;
                    [d.CustoFs * e.Qtds as Custos, d.MoeCusFs, e.Qtds, d.FigJpgs, Space(11) AS OrdImg ] + ;
                    [From SigIvTre e ] + ;
                    [Left Join SigCdPro d On e.CPros = d.CPros ] + ;
                    [Where (e.CBars <> 0 And e.CBars Not In ] + ;
                    [       (Select h1.CBars From SigIvTrh h1 Where h1.CBars <> 0)) Or ] + ;
                    [      (e.CBars = 0 And e.CPros Not In ] + ;
                    [       (Select h1.CPros From SigIvTrh h1 Where h1.CBars = 0)) ] + ;
                    [Union All ] + ;
                    [Select 'Sem Estoque - Sobra' as Ps, d.Mercs, d.CGrus, ] + ;
                    [e.CPros, e.CBars, e.CodCors, e.CodTams, d.Dpros, ] + ;
                    [d.CustoFs * e.Qtds as Custos, d.MoeCusFs, e.Qtds, d.FigJpgs, Space(11) AS OrdImg ] + ;
                    [From SigIvTrh e ] + ;
                    [Left Join SigCdPro d On e.CPros = d.CPros ] + ;
                    [Where (e.CBars <> 0 And e.CBars Not In ] + ;
                    [       (Select h1.CBars From SigIvTre h1 Where h1.CBars <> 0)) Or ] + ;
                    [      (e.CBars = 0 And e.CPros Not In ] + ;
                    [       (Select h1.CPros From SigIvTre h1 Where h1.CBars = 0)) ] + ;
                    [Order By 1, 2, 3, 4, 5]

                IF SQLEXEC(gnConnHandle, lcSql, "cursor_4c_Rel7Tmp") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsRelatorio Tipo7)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM cursor_4c_Rel7Tmp INTO CURSOR CsRelatorio READWRITE
                USE IN cursor_4c_Rel7Tmp

                SELECT CsRelatorio
                SCAN
                    IF EMPTY(CsRelatorio.FigJpgs)
                        REPLACE OrdImg WITH "FBRANCOS" IN CsRelatorio
                    ELSE
                        lcpro = STRTRAN(STRTRAN(ALLTRIM(CsRelatorio.CPros), "/", ""), " ", "")
                        lcDirectory = SYS(2023) + "\F" + ALLTRIM(lcpro) + ".Jpg"
                        REPLACE OrdImg WITH "F" + ALLTRIM(lcpro) IN CsRelatorio
                        lcFoto = STRTRAN(STRTRAN(STRTRAN(CsRelatorio.FigJpgs, ;
                            "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", "")
                        STRTOFILE(STRCONV(lcFoto, 14), lcDirectory)
                    ENDIF
                ENDSCAN

            ENDCASE

            *-- Libera cursores intermediarios
            IF USED("Base")
                USE IN Base
            ENDIF
            IF USED("Saldo")
                USE IN Saldo
            ENDIF
            IF USED("CsEtiqueta")
                USE IN CsEtiqueta
            ENDIF
            IF USED("CsHistorico")
                USE IN CsHistorico
            ENDIF
            IF USED("CsTratam")
                USE IN CsTratam
            ENDIF
            IF USED("Selecao")
                USE IN Selecao
            ENDIF
            IF USED("crTmpHist")
                USE IN crTmpHist
            ENDIF

            *-- Ordenacao final do cursor de saida
            IF USED("CsRelatorio")
                SELECT CsRelatorio
                DO CASE
                    CASE THIS.this_nTipoRel = 1
                        SET ORDER TO Chave1 IN CsRelatorio
                    CASE THIS.this_nTipoRel = 5
                        SET ORDER TO CBars IN CsRelatorio
                    CASE THIS.this_nTipoRel = 7
                        *-- ordem definida no SELECT
                    OTHERWISE
                        SET ORDER TO ORDER("CsRelatorio")
                ENDCASE
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview (equivalente a PROCEDURE visualizacao)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, lcApagar
        loc_lSucesso = .F.

        IF !USED("CsRelatorio")
            THIS.this_cMensagemErro = "Execute PrepararDados() antes de Visualizar()"
            RETURN .F.
        ENDIF

        TRY
            PUBLIC _TipoDif_INV, _lTrataPeso_INV
            _TipoDif_INV    = THIS.this_nTipoDif
            _lTrataPeso_INV = THIS.this_lTrataPeso

            SELECT CsRelatorio
            GO TOP

            DO CASE
                CASE THIS.this_nTipoRel = 1
                    IF THIS.this_nOptFoto = 1
                        REPORT FORM SigReBrf PREVIEW NOCONSOLE ;
                            FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                IIF(!_lTrataPeso_INV, ;
                                    (Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)), ;
                                    ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                    (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops)))))
                    ELSE
                        IF THIS.this_lHorizontal
                            REPORT FORM SigReBlh PREVIEW NOCONSOLE ;
                                FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                    IIF(!_lTrataPeso_INV, ;
                                        (Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)), ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops)))))
                        ELSE
                            REPORT FORM SigReBlr PREVIEW NOCONSOLE ;
                                FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                    IIF(!_lTrataPeso_INV, ;
                                        (Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)), ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops)))))
                        ENDIF
                    ENDIF

                CASE THIS.this_nTipoRel = 2
                    REPORT FORM SigReBla PREVIEW NOCONSOLE

                CASE THIS.this_nTipoRel = 3
                    IF THIS.this_lBalcTrats
                        REPORT FORM SigReBe2 PREVIEW NOCONSOLE
                    ELSE
                        REPORT FORM SigReBle PREVIEW NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 4
                    REPORT FORM SigReBlo PREVIEW NOCONSOLE

                CASE THIS.this_nTipoRel = 5
                    DO FORM SigOpEtq WITH THIS

                CASE THIS.this_nTipoRel = 6
                    REPORT FORM SigReBlb PREVIEW NOCONSOLE

                CASE THIS.this_nTipoRel = 7
                    REPORT FORM SigReBel PREVIEW NOCONSOLE

                CASE THIS.this_nTipoRel = 8
                    REPORT FORM SigReBl3 PREVIEW NOCONSOLE
            ENDCASE

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        lcApagar = SYS(2023) + "\F*.Jpg"
        ERASE &lcApagar.
        RELEASE _TipoDif_INV, _lTrataPeso_INV

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio
    * par_lComPrompt: .T.=abre dialogo de impressora, .F.=imprime silencioso
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir(par_lComPrompt)
        LOCAL loc_lSucesso, loc_oErro, lcApagar
        loc_lSucesso = .F.

        IF !USED("CsRelatorio")
            THIS.this_cMensagemErro = "Execute PrepararDados() antes de Imprimir()"
            RETURN .F.
        ENDIF

        TRY
            PUBLIC _TipoDif_INV, _lTrataPeso_INV
            _TipoDif_INV    = THIS.this_nTipoDif
            _lTrataPeso_INV = THIS.this_lTrataPeso

            SELECT CsRelatorio
            GO TOP

            DO CASE
                CASE THIS.this_nTipoRel = 1
                    IF THIS.this_nOptFoto = 1
                        IF par_lComPrompt
                            REPORT FORM SigReBrf TO PRINTER PROMPT NOCONSOLE ;
                                FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                    ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                    (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                        ELSE
                            REPORT FORM SigReBrf TO PRINTER NOCONSOLE ;
                                FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                    ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                    (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                        ENDIF
                    ELSE
                        IF THIS.this_lHorizontal
                            IF par_lComPrompt
                                REPORT FORM SigReBlh TO PRINTER PROMPT NOCONSOLE ;
                                    FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                            ELSE
                                REPORT FORM SigReBlh TO PRINTER NOCONSOLE ;
                                    FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                            ENDIF
                        ELSE
                            IF par_lComPrompt
                                REPORT FORM SigReBlr TO PRINTER PROMPT NOCONSOLE ;
                                    FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                            ELSE
                                REPORT FORM SigReBlr TO PRINTER NOCONSOLE ;
                                    FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                            ENDIF
                        ENDIF
                    ENDIF

                CASE THIS.this_nTipoRel = 2
                    IF par_lComPrompt
                        REPORT FORM SigReBla TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBla TO PRINTER NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 3
                    IF THIS.this_lBalcTrats
                        IF par_lComPrompt
                            REPORT FORM SigReBe2 TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            REPORT FORM SigReBe2 TO PRINTER NOCONSOLE
                        ENDIF
                    ELSE
                        IF par_lComPrompt
                            REPORT FORM SigReBle TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            REPORT FORM SigReBle TO PRINTER NOCONSOLE
                        ENDIF
                    ENDIF

                CASE THIS.this_nTipoRel = 4
                    IF par_lComPrompt
                        REPORT FORM SigReBlo TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBlo TO PRINTER NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 5
                    DO FORM SigOpEtq WITH THIS

                CASE THIS.this_nTipoRel = 6
                    IF par_lComPrompt
                        REPORT FORM SigReBlb TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBlb TO PRINTER NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 7
                    IF par_lComPrompt
                        REPORT FORM SigReBel TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBel TO PRINTER NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 8
                    IF par_lComPrompt
                        REPORT FORM SigReBl3 TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBl3 TO PRINTER NOCONSOLE
                    ENDIF
            ENDCASE

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        lcApagar = SYS(2023) + "\F*.Jpg"
        ERASE &lcApagar.
        RELEASE _TipoDif_INV, _lTrataPeso_INV

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes de processar
    * Retorna .T. se valido, .F. com mensagem se invalido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF THIS.this_nTipoRel = 2
            DO CASE
                CASE THIS.this_nTipoAnal = 1 AND EMPTY(THIS.this_cProduto)
                    THIS.this_cMensagemErro = "Produto Inv" + CHR(225) + "lido !!!"
                    RETURN .F.
                CASE THIS.this_nTipoAnal = 2 AND EMPTY(THIS.this_cLocal)
                    THIS.this_cMensagemErro = "Local Inv" + CHR(225) + "lido !!!"
                    RETURN .F.
            ENDCASE
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("CsFiltro")
            USE IN CsFiltro
        ENDIF
        IF USED("CsSigCdBal")
            USE IN CsSigCdBal
        ENDIF
        IF USED("CsSigCdPam")
            USE IN CsSigCdPam
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        IF USED("CrSigCdGcr")
            USE IN CrSigCdGcr
        ENDIF
        IF USED("CsOperacaos")
            USE IN CsOperacaos
        ENDIF
        IF USED("CrSMoeda")
            USE IN CrSMoeda
        ENDIF
        IF USED("CsBase")
            USE IN CsBase
        ENDIF
        IF USED("TmpMoeda")
            USE IN TmpMoeda
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
