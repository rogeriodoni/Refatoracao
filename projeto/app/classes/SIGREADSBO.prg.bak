*==============================================================================
* SIGREADSBO.PRG
* Business Object para Relatorio de Apuracao de Descontos/Acrescimos
*
* Form: FormSIGREADS
* Tabelas: SigMvCab, SigMvMov, SigCdCli, SigCdOpe, SigTempR
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SIGREADSBO AS RelatorioBase

    *-- Filtros de empresa
    this_cEmpresa        = ""    && codigo empresa (cEmps em SigCdEmp - Get_Empresa)
    this_cDEmpresa       = ""    && razao social empresa (Razas em SigCdEmp - Get_Dempresa)

    *-- Filtros de vendedor
    this_cVendedor       = ""    && codigo vendedor (Iclis em SigCdCli - Get_Vended)
    this_cDVendedor      = ""    && nome vendedor (Rclis em SigCdCli - Get_Dvend)

    *-- Filtro de operacao
    this_cNmOperacao     = ""    && codigo da operacao (Dopes em SigCdOpe - get_nm_operacao, max 20)

    *-- Filtros de periodo
    this_dDtInicial      = {}    && data inicial do periodo (get_dt_inicial)
    this_dDtFinal        = {}    && data final do periodo (get_dt_final)

    *-- Filtros de moeda
    this_cMoeda          = ""    && codigo moeda (CMoes em SigCdMoe - getCmoeda, max 3)
    this_cDMoeda         = ""    && descricao moeda (DMoes em SigCdMoe - getDmoeda, max 15)

    *-- Filtro de margem
    this_nMargem         = 0     && margem de tolerancia percentual (getMargem, formato 99.99)

    *-- Opcoes de relatorio
    this_nTipoVars       = 1     && tipo variacao: 1=Desconto, 2=Acrescimo, 3=Ambos, 4=Geral (Opt_TipoVars)
    this_nObs            = 0     && imprimir observacoes: 1=Sim, 0=Nao (Opt_obs)
    this_nTipoRel        = 2     && tipo relatorio: 1=Sintetico, 2=Analitico, 3=Resumo (optTipoRel)

    *-- Flags de acesso (fChecaAcesso)
    this_lTitulos        = .F.   && exibe titulos completos (fChecaAcesso 'SigReAds','TITULOS')
    this_lNomeVend       = .F.   && exibe nome do vendedor (fChecaAcesso 'SigReAds','NOMEVEND')

    *-- Dados auxiliares carregados no Init
    this_cGrPadVens      = ""    && GrPadVens de SigCdPam (grupo padrao de vendas para lookup de vendedor)

    *-- Cursores
    this_cCursorDados    = "csRelatorio"         && cursor principal de saida para REPORT FORM
    this_cCursorTipos    = "cursor_4c_TipoOps"   && cursor com tipos de operacao selecionados no grid
    this_cCursorGrupos   = "cursor_4c_GrupoProd" && cursor com grupos de produto selecionados (SCX novo - Grdgrupo)
    this_cIdQuery        = ""                     && ID unico para cleanup de SigTempR no modo analitico

    *--------------------------------------------------------------------------
    * Init - Configura o BO e carrega flags de acesso
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "Numes"
            *-- fChecaAcesso e funcao legada; pode nao existir no ambiente de teste
            *-- TRY aninhado garante que DODEFAULT() sempre seja chamado
            TRY
                THIS.this_lTitulos  = fChecaAcesso("SigReAds", "TITULOS")
                THIS.this_lNomeVend = fChecaAcesso("SigReAds", "NOMEVEND")
            CATCH TO loc_oErroAcesso
                MsgErro(loc_oErroAcesso.Message, "fChecaAcesso")
            ENDTRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosPadrao - Carrega valores iniciais de SigCdPam e empresa
    * Chamado pelo Form apos CREATEOBJECT para pre-preencher campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosPadrao()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Carregar SigCdPam para moeda e grupo padrao de vendas
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 MoePadVens, GrPadVens FROM SigCdPam", ;
                "cursor_4c_SigrPam")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrPam")
                SELECT cursor_4c_SigrPam
                THIS.this_cMoeda     = ALLTRIM(cursor_4c_SigrPam.MoePadVens)
                THIS.this_cGrPadVens = ALLTRIM(cursor_4c_SigrPam.GrPadVens)
            ENDIF
            IF USED("cursor_4c_SigrPam")
                USE IN cursor_4c_SigrPam
            ENDIF

            *-- Empresa e datas padrao
            THIS.this_cEmpresa   = go_4c_Sistema.cCodEmpresa
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()

            *-- Descricao da moeda padrao
            IF !EMPTY(THIS.this_cMoeda)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 DMoes FROM SigCdMoe WHERE CMoes = " + ;
                    EscaparSQL(THIS.this_cMoeda), "cursor_4c_SigrMoe")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrMoe")
                    SELECT cursor_4c_SigrMoe
                    THIS.this_cDMoeda = ALLTRIM(cursor_4c_SigrMoe.DMoes)
                ENDIF
                IF USED("cursor_4c_SigrMoe")
                    USE IN cursor_4c_SigrMoe
                ENDIF
            ENDIF

            *-- Descricao da empresa padrao
            IF !EMPTY(THIS.this_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                    EscaparSQL(THIS.this_cEmpresa), "cursor_4c_SigrEmpPad")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpPad")
                    SELECT cursor_4c_SigrEmpPad
                    THIS.this_cDEmpresa = ALLTRIM(cursor_4c_SigrEmpPad.Razas)
                ENDIF
                IF USED("cursor_4c_SigrEmpPad")
                    USE IN cursor_4c_SigrEmpPad
                ENDIF
            ENDIF

            *-- Valores padrao das opcoes (igual ao legado: TipoVars=3, TipoRel=2)
            THIS.this_nTipoVars = 3
            THIS.this_nTipoRel  = 2
            THIS.this_nObs      = 0
            THIS.this_nMargem   = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacao - Carrega SigCdTom para cursor do grid de tipos
    * par_cCursorDestino: nome do cursor a criar (ex: cursor_4c_TipoOps)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposOperacao(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nResult, loc_nMarca
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF
            CREATE CURSOR (par_cCursorDestino) (Marca N(1), Codigos N(2), Descri C(40))
            INDEX ON Codigos TAG Codigos

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdTom ORDER BY Codigos", ;
                "cursor_4c_SigrTomTmp")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrTomTmp
                SCAN
                    loc_nMarca = IIF(INLIST(cursor_4c_SigrTomTmp.Codigos, 4, 5), 1, 0)
                    INSERT INTO (par_cCursorDestino) (Marca, Codigos, Descri) ;
                        VALUES (loc_nMarca, cursor_4c_SigrTomTmp.Codigos, ;
                                ALLTRIM(STR(cursor_4c_SigrTomTmp.Codigos, 2)) + "-" + ;
                                ALLTRIM(cursor_4c_SigrTomTmp.Descrs))
                ENDSCAN
                USE IN cursor_4c_SigrTomTmp
            ENDIF

            SELECT (par_cCursorDestino)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposProduto - Carrega sigcdgrp para cursor do grid de grupos
    * Equivalente ao Init original: Select cgrus, dgrus From sigcdgrp + Insert
    * em cs_SigCdGrp (Marca n(1), cgrus c(3), dgrus c(40)).
    * par_cCursorDestino: nome do cursor a criar (ex: cursor_4c_GrupoProd)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGruposProduto(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF
            CREATE CURSOR (par_cCursorDestino) (Marca N(1), cgrus C(3), dgrus C(40))
            INDEX ON cgrus TAG cgrus

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cgrus, dgrus FROM sigcdgrp ORDER BY cgrus", ;
                "cursor_4c_SigrGrpTmp")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrGrpTmp
                SCAN
                    INSERT INTO (par_cCursorDestino) (Marca, cgrus, dgrus) ;
                        VALUES (0, cursor_4c_SigrGrpTmp.cgrus, ALLTRIM(cursor_4c_SigrGrpTmp.dgrus))
                ENDSCAN
                USE IN cursor_4c_SigrGrpTmp
            ENDIF

            SELECT (par_cCursorDestino)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega SigCdEmp (exceto oficiais) para lookup
    * par_cCursorDestino: nome do cursor a criar (ex: cursor_4c_SigrJanEmp)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cEmps, Razas, TipoNFs FROM SigCdEmp " + ;
                "WHERE NOT TipoNFs = 2 ORDER BY cEmps", ;
                par_cCursorDestino)
            IF loc_nResult > 0
                SELECT (par_cCursorDestino)
                INDEX ON cEmps TAG cEmps
                INDEX ON Razas TAG Razas
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Descontos/Acrescimos
    * Equivale ao PROCEDURE processamento do legado (SIGREADS.SCX)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_cEmpresa, loc_cOperacao, loc_cVendedor, loc_cMoedaOper
        LOCAL loc_cDtIniStr, loc_cDtFimStr, loc_cDtIniBase, loc_cDtFimBase
        LOCAL loc_nTipoVars, loc_nObs, loc_nTipoRel, loc_nMargem
        LOCAL loc_lAnalitico, loc_cIdQuery
        LOCAL loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo, loc_lNomeVend, loc_cNmEmpresa
        LOCAL loc_cSQL, loc_nResult, loc_cWhere, loc_cNumOp, loc_cWhere1, loc_cWhere2
        LOCAL loc_cEmpDopNums, loc_cUniqueId, loc_nDif, loc_nRec
        LOCAL loc_nTotI1, loc_nTotI2, loc_nResto, loc_nRateio, loc_nVlVend
        LOCAL loc_nItnV, loc_nGerV, loc_cEmpV, loc_cVenV, loc_nNumV
        LOCAL loc_cEmpO, loc_cVenO, loc_nNumO, loc_nMarca

        loc_lSucesso = .F.
        TRY
            *-- 1. Ler filtros das propriedades THIS
            loc_cEmpresa   = ALLTRIM(THIS.this_cEmpresa)
            loc_cOperacao  = ALLTRIM(THIS.this_cNmOperacao)
            loc_cMoedaOper = ALLTRIM(THIS.this_cMoeda)
            loc_cVendedor  = ALLTRIM(THIS.this_cVendedor)
            loc_nTipoVars  = THIS.this_nTipoVars
            loc_nObs       = THIS.this_nObs
            loc_nTipoRel   = THIS.this_nTipoRel
            loc_nMargem    = THIS.this_nMargem
            loc_lAnalitico = (loc_nTipoRel # 1)

            *-- Formatar datas para SQL (DTOS retorna YYYYMMDD)
            loc_cDtIniBase = DTOS(THIS.this_dDtInicial)
            loc_cDtFimBase = DTOS(THIS.this_dDtFinal)
            loc_cDtIniStr  = "'" + SUBSTR(loc_cDtIniBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtIniBase,5,2) + "-" + SUBSTR(loc_cDtIniBase,7,2) + "'"
            loc_cDtFimStr  = "'" + SUBSTR(loc_cDtFimBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtFimBase,5,2) + "-" + SUBSTR(loc_cDtFimBase,7,2) + ;
                              " 23:59:59'"

            *-- 2. Textos do cabecalho
            loc_lcPeriodo = "PERIODO : " + DTOC(THIS.this_dDtInicial) + ;
                            " A " + DTOC(THIS.this_dDtFinal)
            IF THIS.this_lTitulos
                loc_lcTitulo  = "RELA" + CHR(199) + CHR(195) + "O DE APURA" + ;
                                CHR(199) + CHR(195) + "O DE DESCONTOS/ACR" + ;
                                CHR(201) + "SCIMOS"
                loc_lcSubTit  = "MOEDA : " + loc_cMoedaOper + " - " + ;
                                ALLTRIM(THIS.this_cDMoeda) + ;
                                IIF(!EMPTY(loc_nMargem), ;
                                    " - Margem : " + ALLTRIM(STR(loc_nMargem,5,2)) + "%", "")
                loc_lNomeVend = THIS.this_lNomeVend
            ELSE
                loc_lcTitulo  = "RAPDE"
                loc_lcSubTit  = loc_cMoedaOper + ;
                                IIF(!EMPTY(loc_nMargem), ;
                                    " - (" + ALLTRIM(STR(loc_nMargem,5,2)) + "%)", "")
                loc_lNomeVend = .F.
            ENDIF

            *-- 3. Nome da empresa
            loc_cNmEmpresa = loc_cEmpresa
            IF !EMPTY(loc_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                    EscaparSQL(loc_cEmpresa), "cursor_4c_SigrEmpRel")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrEmpRel")
                    SELECT cursor_4c_SigrEmpRel
                    loc_cNmEmpresa = ALLTRIM(cursor_4c_SigrEmpRel.Razas)
                ENDIF
                IF USED("cursor_4c_SigrEmpRel")
                    USE IN cursor_4c_SigrEmpRel
                ENDIF
            ENDIF

            *-- 4. Cursor de cabecalho do relatorio
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (NomeEmp C(80), Titulo C(80), Titulo2 C(200), ;
                                        Titulo3 C(200), tObs N(1), Analitico L(1), ;
                                        NVend L(1), Titulos L(1))
            INSERT INTO csCabecalho ;
                (NomeEmp, Titulo, Titulo2, Titulo3, tObs, Analitico, NVend, Titulos) ;
                VALUES (loc_cNmEmpresa, loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo, ;
                        loc_nObs, loc_lAnalitico, loc_lNomeVend, THIS.this_lTitulos)

            *-- 5. Limpar cursores de execucao anterior
            IF USED("csRelatorio")
                USE IN csRelatorio
            ENDIF
            IF USED("csProdutos")
                USE IN csProdutos
            ENDIF
            IF USED("csSqlEest")
                USE IN csSqlEest
            ENDIF
            IF USED("csSqlEest2")
                USE IN csSqlEest2
            ENDIF
            IF USED("TmpCsRelat")
                USE IN TmpCsRelat
            ENDIF
            IF USED("TmpCsRela2")
                USE IN TmpCsRela2
            ENDIF
            IF USED("csRelatorio1")
                USE IN csRelatorio1
            ENDIF

            *-- 6. Montar clausula de tipos de operacao selecionados no grid
            loc_cNumOp = ""
            IF EMPTY(loc_cOperacao) AND USED(THIS.this_cCursorTipos)
                SELECT (THIS.this_cCursorTipos)
                SCAN
                    IF Marca > 0
                        loc_cNumOp = loc_cNumOp + ;
                            IIF(!EMPTY(loc_cNumOp), " Or ", "(") + ;
                            "o.TipoOps = " + ALLTRIM(STR(Codigos, 2))
                    ENDIF
                ENDSCAN
                IF LEN(loc_cNumOp) > 1
                    loc_cNumOp = loc_cNumOp + ")"
                ENDIF
            ENDIF

            SET DECIMALS TO 2
            SET FIXED ON

            *-- 7. Query 1: SigMvCab+SigMvMov+SigCdCli+SigCdOpe (ValPres = 1 ou 3)
            loc_cWhere = IIF(!EMPTY(loc_cEmpresa), ;
                             "a.Emps = " + EscaparSQL(loc_cEmpresa) + " And ", "") + ;
                         "a.Emps = b.Emps And a.Dopes = b.Dopes And a.Numes = b.Numes And " + ;
                         "a.Datas Between " + loc_cDtIniStr + " And " + loc_cDtFimStr + " And " + ;
                         "a.Dopes = o.Dopes And " + ;
                         IIF(!EMPTY(loc_cOperacao), ;
                             "a.Dopes = " + EscaparSQL(loc_cOperacao) + " And ", "") + ;
                         IIF(!EMPTY(loc_cVendedor), ;
                             "a.Vends = " + EscaparSQL(loc_cVendedor) + " And ", "") + ;
                         "a.Vends = c.Iclis And " + ;
                         IIF(EMPTY(loc_cOperacao) AND !EMPTY(loc_cNumOp), ;
                             loc_cNumOp + " And ", "") + ;
                         "(o.ValPres = 1 Or o.ValPres = 3)"

            loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, " + ;
                       "b.nSinals, b.ValItens, b.Moeds, a.Datas, " + ;
                       "b.ValTots, a.CodObs, a.Obses, a.Usuars " + ;
                       "From SigMvCab a, SigMvMov b, SigCdCli c, SigCdOpe o " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSqlEest")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados (csSqlEest)"
                loc_lSucesso = .F.
            ENDIF

            *-- 8. VFP SELECT cotacao -> TmpCsRelat
            SELECT csSqlEest
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
                   SUM(IIF(nSinals < 0, -1, 1) * ValItens * ;
                       fBuscarCotacao(Moeds, Datas, gnConnHandle) / ;
                       fBuscarCotacao(m.loc_cMoedaOper, Datas, gnConnHandle)) as ValInis, ;
                   (ValTots * fBuscarCotacao(Moeds, Datas, gnConnHandle) / ;
                    fBuscarCotacao(m.loc_cMoedaOper, Datas, gnConnHandle)) as Valos, ;
                   CodObs, "CAB" as Tp, 1 as Soma ;
                   FROM csSqlEest ;
                   INTO CURSOR TmpCsRelat ;
                   GROUP BY Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, 9, CodObs

            *-- 9. Query 2: SigMvCab+SigCdCli+SigCdOpe (NOT ValPres = 1 ou 3)
            loc_cWhere = IIF(!EMPTY(loc_cEmpresa), ;
                             "a.Emps = " + EscaparSQL(loc_cEmpresa) + " And ", "") + ;
                         "a.Datas Between " + loc_cDtIniStr + " And " + loc_cDtFimStr + " And " + ;
                         "Not a.Valvars = 0 And " + ;
                         "a.Dopes = o.Dopes And " + ;
                         IIF(!EMPTY(loc_cOperacao), ;
                             "a.Dopes = " + EscaparSQL(loc_cOperacao) + " And ", "") + ;
                         IIF(!EMPTY(loc_cVendedor), ;
                             "a.Vends = " + EscaparSQL(loc_cVendedor) + " And ", "") + ;
                         "a.Vends = c.Iclis And " + ;
                         IIF(EMPTY(loc_cOperacao) AND !EMPTY(loc_cNumOp), ;
                             loc_cNumOp + " And ", "") + ;
                         "Not (o.ValPres = 1 Or o.ValPres = 3)"

            loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.Vends, c.Rclis, " + ;
                       "a.ValInis, o.cMoes, a.Datas, " + ;
                       "a.Valos, a.CodObs, a.Obses, a.Usuars " + ;
                       "From SigMvCab a, SigCdCli c, SigCdOpe o " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csSqlEest2")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados (csSqlEest2)"
                loc_lSucesso = .F.
            ENDIF

            *-- 10. VFP SELECT cotacao -> TmpCsRela2
            SELECT csSqlEest2
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, ;
                   SUM(ValInis * ;
                       IIF(EMPTY(cMoes), 1, fBuscarCotacao(cMoes, Datas, gnConnHandle)) / ;
                       fBuscarCotacao(m.loc_cMoedaOper, Datas, gnConnHandle)) as ValInis, ;
                   (Valos * ;
                    IIF(EMPTY(cMoes), 1, fBuscarCotacao(cMoes, Datas, gnConnHandle)) / ;
                    fBuscarCotacao(m.loc_cMoedaOper, Datas, gnConnHandle)) as Valos, ;
                   CodObs, "CAB" as Tp, 1 as Soma ;
                   FROM csSqlEest2 ;
                   INTO CURSOR TmpCsRela2 ;
                   GROUP BY Emps, Dopes, Numes, MascNum, Vends, Rclis, Usuars, 9, CodObs

            *-- 11. Condicoes de filtro por tipo de variacao
            loc_cWhere1 = IIF(loc_nTipoVars=1, ;
                              "ValInis > Valos Or (ValInis = 0 And Not Valos = 0)", ;
                          IIF(loc_nTipoVars=2, "ValInis < Valos Or ValInis = 0", ;
                          IIF(loc_nTipoVars=3, "Not ValInis = Valos", "0=0")))

            loc_cWhere2 = IIF(loc_nTipoVars=1, "ValInis > Valos", ;
                          IIF(loc_nTipoVars=2, "ValInis < Valos", ;
                          IIF(loc_nTipoVars=3, "Not ValInis = Valos", "0=0")))

            *-- 12. UNION ALL das duas selects -> csRelatorio1
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, ;
                   Tp, Soma, ;
                   SPACE(14) as CPros, 00000000000000 as CBars, ;
                   SPACE(40) as DPros, SPACE(1) as Opers, ;
                   000000.00 as Qtds, 00000.000000 as Units, ;
                   000000000.00 as Totas, 000000000.00 as DifVal, Usuars ;
                   FROM TmpCsRelat ;
                   WHERE &loc_cWhere1. ;
                   UNION ALL ;
            SELECT Emps, Dopes, Numes, MascNum, Vends, Rclis, ValInis, Valos, CodObs, ;
                   Tp, Soma, ;
                   SPACE(14) as CPros, 00000000000000 as CBars, ;
                   SPACE(40) as DPros, SPACE(1) as Opers, ;
                   000000.00 as Qtds, 00000.000000 as Units, ;
                   000000000.00 as Totas, 000000000.00 as DifVal, Usuars ;
                   FROM TmpCsRela2 ;
                   WHERE &loc_cWhere2. ;
                   INTO CURSOR csRelatorio1 ;
                   ORDER BY 1, 5, 2, 3, 11

            *-- 13. Cursor de observacoes unificado
            IF USED("TmpObses")
                USE IN TmpObses
            ENDIF
            SELECT Emps, Dopes, Numes, Obses FROM csSqlEest ;
            UNION ALL ;
            SELECT Emps, Dopes, Numes, Obses FROM csSqlEest2 ;
            INTO CURSOR TmpObses ;
            ORDER BY 1, 2, 3

            *-- 14. Left join observacoes -> csRelatorio READWRITE
            SELECT a.*, b.Obses FROM csRelatorio1 a ;
                               LEFT JOIN TmpObses b ;
                               ON a.Emps = b.Emps AND a.Dopes = b.Dopes AND ;
                                  a.Numes = b.Numes ;
                               INTO CURSOR csRelatorio READWRITE

            SELECT csRelatorio
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
            INDEX ON Emps + Vends + Dopes + STR(Numes, 6) + Tp TAG VdDpNmTp

            *-- 15. Filtrar pela margem de tolerancia
            IF !EMPTY(loc_nMargem)
                SELECT csRelatorio
                SCAN
                    IF ABS(100 - ((Valos*100) / IIF(ValInis#0, ValInis, 1))) < loc_nMargem
                        DELETE
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 16. Modo analitico: inserir cabecalhos em SigTempR e buscar produtos
            IF loc_lAnalitico
                loc_cIdQuery = SYS(2015)
                THIS.this_cIdQuery = loc_cIdQuery

                *-- Limpar registros anteriores desta query
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE CIdQuerys = " + EscaparSQL(loc_cIdQuery))

                *-- Inserir cada cabecalho no SigTempR via SQL
                SELECT csRelatorio
                GO TOP
                SCAN
                    loc_cEmpDopNums = PADR(csRelatorio.Emps, 3) + ;
                                      PADR(csRelatorio.Dopes, 20) + ;
                                      STR(csRelatorio.Numes, 6)
                    loc_cUniqueId = SYS(2015)

                    loc_cSQL = "INSERT INTO SigTempR " + ;
                               "(Emps, Dopes, Numes, MascNum, CPros, Razas, Valors, Qtds, " + ;
                               "CodObs, Obss, EmpDopNums, CIdQuerys, CIdChaves, Contas) " + ;
                               "VALUES (" + ;
                               EscaparSQL(csRelatorio.Emps) + ", " + ;
                               EscaparSQL(csRelatorio.Dopes) + ", " + ;
                               TRANSFORM(csRelatorio.Numes) + ", " + ;
                               EscaparSQL(csRelatorio.MascNum) + ", " + ;
                               EscaparSQL(csRelatorio.Vends) + ", " + ;
                               EscaparSQL(LEFT(csRelatorio.RClis, 40)) + ", " + ;
                               FormatarNumeroSQL(csRelatorio.Valos) + ", " + ;
                               FormatarNumeroSQL(csRelatorio.ValInis) + ", " + ;
                               FormatarNumeroSQL(csRelatorio.CodObs, 0) + ", " + ;
                               EscaparSQL(csRelatorio.Obses) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               EscaparSQL(loc_cIdQuery) + ", " + ;
                               EscaparSQL(loc_cUniqueId) + ", " + ;
                               EscaparSQL(csRelatorio.Usuars) + ")"

                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT csRelatorio
                ENDSCAN

                *-- Buscar produtos de SigTempR + SigMvItn
                loc_cSQL = "Select a.Emps, a.Dopes, a.Numes, a.MascNum, a.CPros As Vends, " + ;
                           "a.Razas As RClis, a.Qtds As ValInis, a.Valors As Valos, " + ;
                           "a.CodObs, a.Obss as Obses, 'ITN' as Tp, 0 as Soma, " + ;
                           "b.CPros, b.CodBarras as CBars, b.DPros, b.Opers, b.Qtds, " + ;
                           "b.Totas As Units, b.Totas, 99999999.99 as DifVal, " + ;
                           "a.Contas as Usuars " + ;
                           "From SigTempR a, SigMvItn b " + ;
                           "Where a.EmpDopNums = b.EmpDopNums And a.CIdQuerys = " + ;
                           EscaparSQL(loc_cIdQuery)

                IF USED("csProdutos")
                    USE IN csProdutos
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csProdutos")

                IF loc_nResult > 0
                    SELECT csProdutos
                    INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                    INDEX ON Emps + Vends + STR(Numes, 6) TAG EmpVenNum

                    *-- Calcular DifVal (diferenca real paga) por nota
                    SET ORDER TO EmpDopNum
                    REPLACE ALL DifVal WITH 0

                    SCAN
                        loc_nDif = 0
                        IF USED("crSigMvMov")
                            USE IN crSigMvMov
                        ENDIF
                        loc_cSQL = "SELECT ValtOts, Nsinals, ValItens FROM SigMvMov " + ;
                                   "WHERE EmpDopNums = " + ;
                                   EscaparSQL(csProdutos.Emps + csProdutos.Dopes + ;
                                              STR(csProdutos.Numes, 6))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvMov") > 0
                            SELECT crSigMvMov
                            SCAN
                                loc_nDif = loc_nDif + crSigMvMov.Valtots - ;
                                           (crSigMvMov.Nsinals * crSigMvMov.Valitens)
                            ENDSCAN
                            USE IN crSigMvMov
                        ENDIF
                        REPLACE DifVal WITH loc_nDif IN csProdutos
                        SELECT csProdutos
                    ENDSCAN

                    *-- Calcular rateio de desconto/acrescimo por produto
                    SET ORDER TO EmpVenNum
                    GO TOP
                    DO WHILE !EOF()
                        loc_cEmpV  = csProdutos.Emps
                        loc_cVenV  = csProdutos.Vends
                        loc_nNumV  = csProdutos.Numes
                        loc_nTotI1 = 0
                        loc_nRec   = RECNO()
                        loc_nDif   = 0
                        loc_nItnV  = 0
                        loc_nGerV  = 0

                        SCAN WHILE csProdutos.Emps=loc_cEmpV AND ;
                                    csProdutos.Vends=loc_cVenV AND ;
                                    csProdutos.Numes=loc_nNumV
                            IF !INLIST(csProdutos.Cpros, ;
                                       PADR("CP",14), PADR("CR",14), ;
                                       PADR("C",14), PADR("E",14)) ;
                               AND csProdutos.Opers = "S"
                                loc_nItnV  = loc_nItnV + csProdutos.Totas
                                loc_nTotI1 = loc_nTotI1 + 1
                            ENDIF
                            loc_nGerV = loc_nGerV + csProdutos.Totas
                            loc_nDif  = IIF(EMPTY(loc_nDif), csProdutos.DifVal, loc_nDif)
                        ENDSCAN

                        loc_nResto = loc_nDif
                        IF loc_nGerV < 0
                            loc_nResto = ABS(loc_nResto)
                        ENDIF

                        loc_nTotI2 = 0
                        GO loc_nRec
                        SCAN WHILE csProdutos.Emps=loc_cEmpV AND ;
                                    csProdutos.Vends=loc_cVenV AND ;
                                    csProdutos.Numes=loc_nNumV
                            IF !INLIST(csProdutos.Cpros, ;
                                       PADR("CP",14), PADR("CR",14), ;
                                       PADR("C",14), PADR("E",14)) ;
                               AND csProdutos.Opers = "S"
                                loc_nTotI2 = loc_nTotI2 + 1
                                loc_nRateio = ROUND(loc_nDif * ;
                                    (csProdutos.Totas / IIF(loc_nItnV <> 0, loc_nItnV, 1)), 0)
                                IF loc_nTotI1 = loc_nTotI2
                                    loc_nVlVend = csProdutos.Totas + loc_nResto
                                ELSE
                                    loc_nVlVend = csProdutos.Totas + loc_nRateio
                                    loc_nResto  = loc_nResto - loc_nRateio
                                ENDIF
                                REPLACE Totas WITH loc_nVlVend IN csProdutos
                            ENDIF
                        ENDSCAN
                    ENDDO

                    *-- Inserir produtos processados no csRelatorio
                    SELECT csProdutos
                    SCAN
                        INSERT INTO csRelatorio ;
                            (Emps, Dopes, Numes, MascNum, Vends, Rclis, ;
                             ValInis, Valos, CodObs, Obses, Tp, Soma, ;
                             CPros, CBars, DPros, Opers, Qtds, Units, ;
                             Totas, DifVal, Usuars) ;
                            VALUES (csProdutos.Emps, csProdutos.Dopes, ;
                                    csProdutos.Numes, csProdutos.MascNum, ;
                                    csProdutos.Vends, csProdutos.RClis, ;
                                    0, 0, csProdutos.CodObs, csProdutos.Obses, ;
                                    csProdutos.Tp, csProdutos.Soma, ;
                                    csProdutos.CPros, csProdutos.CBars, ;
                                    csProdutos.DPros, csProdutos.Opers, ;
                                    csProdutos.Qtds, csProdutos.Units, ;
                                    csProdutos.Totas, csProdutos.DifVal, ;
                                    csProdutos.Usuars)
                    ENDSCAN
                ENDIF

                *-- Limpar SigTempR desta query
                SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigTempR WHERE CIdQuerys = " + EscaparSQL(loc_cIdQuery))
                THIS.this_cIdQuery = ""
            ENDIF

            *-- 17. Processar observacoes (marcar registros OB)
            IF loc_nObs = 1
                SELECT csRelatorio
                SET ORDER TO VdDpNmTp DESCENDING
                loc_cEmpO = ""
                loc_cVenO = ""
                loc_nNumO = 0
                SCAN
                    IF loc_cEmpO # csRelatorio.Emps OR ;
                       loc_cVenO # csRelatorio.Vends OR ;
                       loc_nNumO # csRelatorio.Numes
                        REPLACE Tp WITH "OB" + SUBS(csRelatorio.Tp, 1, 1) IN csRelatorio
                        loc_cEmpO = csRelatorio.Emps
                        loc_cVenO = csRelatorio.Vends
                        loc_nNumO = csRelatorio.Numes
                    ENDIF
                ENDSCAN
                SET ORDER TO VdDpNmTp ASCENDING
            ENDIF

            *-- 18. Modo Resumo: agregar por empresa
            IF loc_nTipoRel = 3
                IF USED("csTot1")
                    USE IN csTot1
                ENDIF
                IF USED("csTot2")
                    USE IN csTot2
                ENDIF

                SELECT Emps, COUNT(1) as TotSoma ;
                       FROM TmpCsRelat ;
                       GROUP BY Emps ;
                       INTO CURSOR csTot1
                INDEX ON Emps TAG Emps

                SELECT Emps, COUNT(1) as TotSoma ;
                       FROM TmpCsRela2 ;
                       GROUP BY Emps ;
                       INTO CURSOR csTot2
                INDEX ON Emps TAG Emps

                IF USED("csRelatorio")
                    USE IN csRelatorio
                ENDIF
                SELECT Emps, ;
                       SUM(ValInis) as ValInis, ;
                       SUM(Valos) as Valos, ;
                       SUM(IIF(ValInis > Valos, ValInis - Valos, 0)) as Desconto, ;
                       SUM(IIF(Valos > ValInis, Valos - ValInis, 0)) as Acrescimo, ;
                       SUM(Soma) as Soma, ;
                       0 as TotSoma ;
                       FROM csRelatorio ;
                       GROUP BY Emps ;
                       INTO CURSOR csRelatorio READWRITE

                SELECT csRelatorio
                SCAN
                    IF SEEK(csRelatorio.Emps, "csTot1", "Emps")
                        REPLACE TotSoma WITH TotSoma + csTot1.TotSoma IN csRelatorio
                    ENDIF
                    IF SEEK(csRelatorio.Emps, "csTot2", "Emps")
                        REPLACE TotSoma WITH TotSoma + csTot2.TotSoma IN csRelatorio
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 19. Posicionar no inicio
            SELECT csRelatorio
            SET ORDER TO VdDpNmTp
            GOTO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirRelatorio - Executa REPORT FORM com dados preparados
    * par_lVisualizar: .T. = visualizar na tela, .F. = imprimir direto
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirRelatorio(par_lVisualizar)
        LOCAL loc_lSucesso, loc_cFrx, loc_cModo
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                THIS.this_cMensagemErro = "Erro ao preparar dados para o relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ELSE
                loc_cFrx = IIF(THIS.this_nTipoRel = 3, "SigReAd2", "SigReAd1")
                loc_cModo = IIF(par_lVisualizar, "PREVIEW", "PRINTER_PROMPT")
                loc_lSucesso = THIS.ExecutarReportForm(loc_cFrx, loc_cModo, "csRelatorio")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm (Pattern #117)
    *   Guard FILE(FRX) + guard cursor vazio + isolamento locale/REPORTBEHAVIOR
    *   par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

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

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao do relatorio
    * par_cAliasCursor: nome do cursor com colunas de filtro (formato preset)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset nao disponivel: " + ;
                                          ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            *-- SCATTER MEMVAR para acessar colunas dinamicamente
            SCATTER MEMVAR

            IF TYPE("m.cEmpresa") = "C"
                THIS.this_cEmpresa = ALLTRIM(m.cEmpresa)
            ENDIF
            IF TYPE("m.cDEmpresa") = "C"
                THIS.this_cDEmpresa = ALLTRIM(m.cDEmpresa)
            ENDIF
            IF TYPE("m.cVendedor") = "C"
                THIS.this_cVendedor = ALLTRIM(m.cVendedor)
            ENDIF
            IF TYPE("m.cDVendedor") = "C"
                THIS.this_cDVendedor = ALLTRIM(m.cDVendedor)
            ENDIF
            IF TYPE("m.cNmOperacao") = "C"
                THIS.this_cNmOperacao = ALLTRIM(m.cNmOperacao)
            ENDIF
            IF TYPE("m.dDtInicial") = "D"
                THIS.this_dDtInicial = m.dDtInicial
            ENDIF
            IF TYPE("m.dDtFinal") = "D"
                THIS.this_dDtFinal = m.dDtFinal
            ENDIF
            IF TYPE("m.cMoeda") = "C"
                THIS.this_cMoeda = ALLTRIM(m.cMoeda)
            ENDIF
            IF TYPE("m.cDMoeda") = "C"
                THIS.this_cDMoeda = ALLTRIM(m.cDMoeda)
            ENDIF
            IF TYPE("m.nMargem") = "N"
                THIS.this_nMargem = m.nMargem
            ENDIF
            IF TYPE("m.nTipoVars") = "N"
                THIS.this_nTipoVars = m.nTipoVars
            ENDIF
            IF TYPE("m.nObs") = "N"
                THIS.this_nObs = m.nObs
            ENDIF
            IF TYPE("m.nTipoRel") = "N"
                THIS.this_nTipoRel = m.nTipoRel
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Delega para ImprimirRelatorio(.F.) e registra auditoria de impressao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          " obrigat" + CHR(243) + "rio para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria para gerar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ImprimirRelatorio(.F.)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Delega para ImprimirRelatorio(.T.) e registra auditoria de visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo (data inicial/final) " + ;
                                          " obrigat" + CHR(243) + "rio para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria para visualizar relat" + ;
                                          CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ImprimirRelatorio(.T.)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = "EMP=" + ALLTRIM(THIS.this_cEmpresa) + ;
                         ";PER=" + DTOC(THIS.this_dDtInicial) + "-" + DTOC(THIS.this_dDtFinal) + ;
                         ";VEND=" + ALLTRIM(THIS.this_cVendedor) + ;
                         ";OPE=" + ALLTRIM(THIS.this_cNmOperacao) + ;
                         ";MOE=" + ALLTRIM(THIS.this_cMoeda) + ;
                         ";TR=" + ALLTRIM(STR(THIS.this_nTipoRel, 1))

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReAds") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores e remove registros temporarios de SigTempR
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cIdQuery)
            SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigTempR WHERE CIdQuerys = " + ;
                EscaparSQL(THIS.this_cIdQuery))
            THIS.this_cIdQuery = ""
        ENDIF
        IF USED("csRelatorio")
            USE IN csRelatorio
        ENDIF
        IF USED("csProdutos")
            USE IN csProdutos
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("csSqlEest")
            USE IN csSqlEest
        ENDIF
        IF USED("csSqlEest2")
            USE IN csSqlEest2
        ENDIF
        IF USED("TmpCsRelat")
            USE IN TmpCsRelat
        ENDIF
        IF USED("TmpCsRela2")
            USE IN TmpCsRela2
        ENDIF
        IF USED("TmpObses")
            USE IN TmpObses
        ENDIF
        IF USED("csRelatorio1")
            USE IN csRelatorio1
        ENDIF
        IF USED("csTot1")
            USE IN csTot1
        ENDIF
        IF USED("csTot2")
            USE IN csTot2
        ENDIF
        IF USED(THIS.this_cCursorTipos)
            USE IN (THIS.this_cCursorTipos)
        ENDIF
        IF USED(THIS.this_cCursorGrupos)
            USE IN (THIS.this_cCursorGrupos)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
