*==============================================================================
* SIGREETLBO.PRG
* Business Object para Relatorio de Estoque Por Localizacao (SigReEtl)
*
* Herda de RelatorioBase
* Relatorio: SigReEt1 a SigReEt7 (selecao por tipo)
*==============================================================================

DEFINE CLASS SigReEtlBO AS RelatorioBase

    *-- Identificacao
    this_cMensagemErro  = ""
    this_cCursorDados   = "cursor_4c_Dados"
    this_cFRXAtual      = ""

    *-- Filtros: Empresa
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtros: Grupo contabilidade / Conta de estoque
    this_cGrupo         = ""
    this_cDGrupo        = ""
    this_cConta         = ""
    this_cDConta        = ""

    *-- Filtros: Grupo de Venda (Colecao - SigCdCol)
    this_cCol           = ""
    this_cDCol          = ""

    *-- Filtros: Localizacao hierarquica (Base=Nvl1, Nvl2, Nvl3, Nvl4)
    this_cBase          = ""
    this_cDBase         = ""
    this_cNvl2          = ""
    this_cDNvl2         = ""
    this_cNvl3          = ""
    this_cDNvl3         = ""
    this_cNvl4          = ""
    this_cDNvl4         = ""

    *-- Filtros: Localizacao direta (SigPrLcl)
    this_cLocal         = ""
    this_cDLocal        = ""

    *-- Filtros: Grande Grupo (SigCdGpr)
    this_cCSGru         = ""
    this_cDSGru         = ""

    *-- Filtros: Grupo de Produto (SigCdGrp)
    this_cCgru          = ""
    this_cDgru          = ""

    *-- Filtros: Subgrupo (SigCdPsg)
    this_cCSubG         = ""
    this_cDSubG         = ""

    *-- Filtros: Produto (SigCdPro)
    this_cCdProduto     = ""
    this_cDsProduto     = ""

    *-- Filtros: Fornecedor
    this_cForn          = ""
    this_cDForn         = ""

    *-- Opcoes: Tipo de relatorio (optSinAna)
    *   1=Sintetico  2=Analitico  3=Com Descricao  4=Estoque por Localizacao
    *   5=Analitico Com Descricao  6=Sintetico Com Descricao
    this_nTipoRelatorio = 1

    *-- Opcoes: SubTotais Grupo/Subgrupo (Opt_Subt - checkbox 0/1)
    this_nSubTotais     = 0

    *-- Opcoes: Ordenacao (OptOrdem)
    *   1=Primeiro Nivel  2=Segundo Nivel  3=Terceiro Nivel  4=Quarto Nivel
    this_nOrdem         = 1

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosIniciais - Carrega empresa, grupo, conta e hierarquia de
    * localizacao. Chamado pelo Form.InicializarForm() apos criar o BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosIniciais()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_oErro
        LOCAL loc_cGrupoEsts, loc_cContaEsts, loc_lOK
        loc_lSucesso = .F.
        TRY
            loc_lOK = .T.

            *-- Empresa
            loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar empresa"
                loc_lOK = .F.
            ENDIF

            IF loc_lOK
                SELECT cursor_4c_CrSigCdEmp
                GO TOP
                IF !EOF()
                    THIS.this_cEmpresa  = ALLTRIM(cursor_4c_CrSigCdEmp.cemps)
                    THIS.this_cDEmpresa = ALLTRIM(cursor_4c_CrSigCdEmp.razas)
                ENDIF

                *-- Parametros: Grupo e Conta de estoque
                loc_cGrupoEsts = ""
                loc_cContaEsts = ""
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT grupoests, contaests FROM SigCdPam", "cursor_4c_CrSigCdPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_CrSigCdPam
                    GO TOP
                    IF !EOF()
                        loc_cGrupoEsts = ALLTRIM(cursor_4c_CrSigCdPam.grupoests)
                        loc_cContaEsts = ALLTRIM(cursor_4c_CrSigCdPam.contaests)
                    ENDIF
                ENDIF

                *-- Grupo de estoque
                IF !EMPTY(loc_cGrupoEsts)
                    loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                               EscaparSQL(loc_cGrupoEsts)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGccr")
                    IF loc_nResult > 0
                        SELECT cursor_4c_TmpGccr
                        GO TOP
                        IF !EOF()
                            THIS.this_cGrupo  = ALLTRIM(cursor_4c_TmpGccr.codigos)
                            THIS.this_cDGrupo = ALLTRIM(cursor_4c_TmpGccr.descrs)
                        ENDIF
                    ENDIF
                ENDIF

                *-- Conta de estoque
                IF !EMPTY(loc_cContaEsts)
                    loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                               EscaparSQL(loc_cContaEsts)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                    IF loc_nResult > 0
                        SELECT cursor_4c_TmpCli
                        GO TOP
                        IF !EOF()
                            THIS.this_cConta  = ALLTRIM(cursor_4c_TmpCli.iclis)
                            THIS.this_cDConta = ALLTRIM(cursor_4c_TmpCli.rclis)
                        ENDIF
                    ENDIF
                ENDIF

                *-- Hierarquia de localizacao (niveis 1 a 4)
                SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv1", "csNivel1")
                SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv2", "csNivel2")
                SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv3", "csNivel3")
                SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv4", "csNivel4")

                *-- Cria cursors expandidos com campo Codigo adicional
                SELECT csNivel1
                SELECT *, SPACE(4) AS Codigo FROM csNivel1 WHERE 1=0 INTO CURSOR crSigLcNv1 READWRITE

                SELECT csNivel2
                SELECT *, SPACE(4) AS Codigo FROM csNivel2 WHERE 1=0 INTO CURSOR crSigLcNv2 READWRITE

                SELECT csNivel3
                SELECT *, SPACE(4) AS Codigo FROM csNivel3 WHERE 1=0 INTO CURSOR crSigLcNv3 READWRITE

                SELECT csNivel4
                SELECT *, SPACE(4) AS Codigo FROM csNivel4 WHERE 1=0 INTO CURSOR crSigLcNv4 READWRITE

                *-- Processa hierarquia XML
                THIS.ReverterXML("csNivel2", "csNivel1", "crSigLcNv2")
                THIS.ReverterXML("csNivel3", "csNivel2", "crSigLcNv3")
                THIS.ReverterXML("csNivel4", "csNivel3", "crSigLcNv4")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarDadosIniciais")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta clausulas WHERE e executa queries conforme filtros.
    * Popula CsImpressao (dados) e csCabecalho (cabecalho) para os FRX files.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lOK, loc_cWhere, loc_cWhere2
        LOCAL loc_cSQL, loc_cSQL2, loc_nResult, loc_cLocNew, loc_oErro
        LOCAL loc_cNvl3Local
        loc_lSucesso = .F.
        TRY
            loc_lOK = .T.
            THIS.this_cMensagemErro = ""

            *-- Localizacao hierarquica composta (Base+Nvl2+Nvl3+Nvl4)
            loc_cLocNew = ALLTRIM(THIS.this_cBase) + ALLTRIM(THIS.this_cNvl2) + ;
                          ALLTRIM(THIS.this_cNvl3) + ALLTRIM(THIS.this_cNvl4)

            *-- WHERE para SigOpEtq (alias a) com join SigCdPro (alias B)
            loc_cWhere = "a.empos = '" + ALLTRIM(THIS.this_cEmpresa) + ;
                         "' AND a.grupos = '" + ALLTRIM(THIS.this_cGrupo) + "' "
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + "AND a.contas = '" + ALLTRIM(THIS.this_cConta) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cLocal)
                loc_cWhere = loc_cWhere + "AND a.localizas LIKE '" + ALLTRIM(THIS.this_cLocal) + "%' "
            ENDIF
            IF !EMPTY(loc_cLocNew)
                loc_cWhere = loc_cWhere + "AND a.localizas LIKE '" + loc_cLocNew + "%' "
            ENDIF
            IF !EMPTY(THIS.this_cCgru)
                loc_cWhere = loc_cWhere + "AND B.Cgrus = '" + ALLTRIM(THIS.this_cCgru) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCSGru)
                loc_cWhere = loc_cWhere + "AND B.Mercs = '" + ALLTRIM(THIS.this_cCSGru) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCSubG)
                loc_cWhere = loc_cWhere + "AND B.SGrus = '" + ALLTRIM(THIS.this_cCSubG) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCdProduto)
                loc_cWhere = loc_cWhere + "AND B.Cpros = '" + ALLTRIM(THIS.this_cCdProduto) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cForn)
                loc_cWhere = loc_cWhere + "AND B.IFors = '" + ALLTRIM(THIS.this_cForn) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCol)
                loc_cWhere = loc_cWhere + "AND B.Colecoes = '" + ALLTRIM(THIS.this_cCol) + "' "
            ENDIF

            *-- WHERE para SigMvesl (alias a) com join SigCdPro (alias b)
            loc_cWhere2 = "a.emps = '" + ALLTRIM(THIS.this_cEmpresa) + ;
                          "' AND a.grupos = '" + ALLTRIM(THIS.this_cGrupo) + "' "
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere2 = loc_cWhere2 + "AND a.estos = '" + ALLTRIM(THIS.this_cConta) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cLocal)
                loc_cWhere2 = loc_cWhere2 + "AND a.locals LIKE '" + ALLTRIM(THIS.this_cLocal) + "%' "
            ENDIF
            IF !EMPTY(loc_cLocNew)
                loc_cWhere2 = loc_cWhere2 + "AND a.locals LIKE '" + loc_cLocNew + "%' "
            ENDIF
            IF !EMPTY(THIS.this_cCgru)
                loc_cWhere2 = loc_cWhere2 + "AND B.Cgrus = '" + ALLTRIM(THIS.this_cCgru) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCSGru)
                loc_cWhere2 = loc_cWhere2 + "AND B.Mercs = '" + ALLTRIM(THIS.this_cCSGru) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCSubG)
                loc_cWhere2 = loc_cWhere2 + "AND B.SGrus = '" + ALLTRIM(THIS.this_cCSubG) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCdProduto)
                loc_cWhere2 = loc_cWhere2 + "AND B.Cpros = '" + ALLTRIM(THIS.this_cCdProduto) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cForn)
                loc_cWhere2 = loc_cWhere2 + "AND B.IFors = '" + ALLTRIM(THIS.this_cForn) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCol)
                loc_cWhere2 = loc_cWhere2 + "AND B.Colecoes = '" + ALLTRIM(THIS.this_cCol) + "' "
            ENDIF

            *-- Monta cabecalho do relatorio
            THIS.MontarCabecalho()

            *-- Executa query conforme tipo de relatorio
            DO CASE
            CASE INLIST(THIS.this_nTipoRelatorio, 1, 6)
                *-- Sintetico / Sintetico Com Descricao: UNION ALL de SigOpEtq + SigMvesl
                loc_cSQL = "SELECT localizas, COUNT(1) AS qtde, 1 AS agrupar, SPACE(100) AS Descrs " + ;
                    "FROM SigOpEtq A " + ;
                    "LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus,IFors FROM SigCdPro) B " + ;
                    "ON b.cpros = a.cpros " + ;
                    "WHERE " + loc_cWhere + "GROUP BY A.localizas"

                loc_cSQL2 = "SELECT a.locals, SUM(a.sqtds) AS qtde, 1 AS agrupar, SPACE(100) AS Descrs " + ;
                    "FROM SigMvesl a, SigCdpro b " + ;
                    "WHERE a.CPros = b.Cpros AND " + loc_cWhere2 + ;
                    "AND a.Locals NOT IN(" + ;
                    "SELECT localizas FROM SigOpEtq A " + ;
                    "LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus,IFors FROM SigCdPro) B " + ;
                    "ON b.cpros = a.cpros " + ;
                    "WHERE " + loc_cWhere + "GROUP BY A.localizas" + ;
                    ") GROUP BY a.locals ORDER BY 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL + " UNION ALL " + loc_cSQL2, "CsDados1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao executar query sint" + CHR(233) + "tico"
                    loc_lOK = .F.
                ENDIF

                IF loc_lOK
                    SELECT localizas, SUM(qtde) AS qtde, 2 AS agrupar, Descrs ;
                        FROM CsDados1 ;
                        GROUP BY 1, 3, 4 ;
                        INTO CURSOR CsDados2 READWRITE

                    SELECT localizas, qtde, agrupar, Descrs ;
                        FROM CsDados1 ;
                        UNION ALL ;
                        SELECT localizas, qtde, agrupar, Descrs ;
                        FROM CsDados2 ;
                        INTO CURSOR CsImpressao READWRITE
                ENDIF

            CASE INLIST(THIS.this_nTipoRelatorio, 2, 5)
                *-- Analitico / Analitico Com Descricao
                loc_cSQL = "SELECT a.localizas, a.cpros, a.cbars, " + ;
                    "ISNULL(c.cbars_old,0) AS Cbars_old, 1 AS agrupar, SPACE(100) AS Descrs " + ;
                    "FROM SigOpEtq A " + ;
                    "LEFT JOIN SigOpEta c ON a.cbars = c.cbars_new " + ;
                    "LEFT JOIN (SELECT Cpros AS Cpros2,Cgrus,Mercs,Colecoes,Sgrus,IFors FROM SigCdPro) B " + ;
                    "ON b.Cpros2 = a.cpros " + ;
                    "WHERE " + loc_cWhere + ;
                    "GROUP BY A.localizas, A.cbars, A.Cpros, c.cbars_old"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsImpressao")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao executar query anal" + CHR(237) + "tico"
                    loc_lOK = .F.
                ENDIF
                IF loc_lOK
                    SELECT CsImpressao
                    INDEX ON localizas + ALLTRIM(STR(cbars)) TAG idxcsimp
                ENDIF

            CASE THIS.this_nTipoRelatorio = 3
                *-- Com Descricao
                loc_cSQL = "SELECT a.Localizas, a.CPros, a.CBars, " + ;
                    "ISNULL(c.cbars_old,0) AS Cbars_old, " + ;
                    "b.DPros, b.Reffs, b.PVens, b.CGrus, b.SGrus, 1 AS Agrupar " + ;
                    "FROM SigOpEtq a " + ;
                    "LEFT JOIN SigOpEta c ON a.cbars = c.cbars_new " + ;
                    ", SigCdpro b " + ;
                    "WHERE a.CPros = b.Cpros AND " + loc_cWhere + ;
                    "GROUP BY a.Localizas, a.CBars, a.CPros, " + ;
                    "b.DPros, b.Reffs, b.PVens, b.CGrus, b.SGrus, c.cbars_old"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsImpressao")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao executar query com descri" + CHR(231) + CHR(227) + "o"
                    loc_lOK = .F.
                ENDIF
                IF loc_lOK
                    IF THIS.this_nSubTotais = 0
                        SELECT CsImpressao
                        INDEX ON localizas + ALLTRIM(STR(cbars)) TAG idxcsimp
                    ELSE
                        SELECT CsImpressao
                        INDEX ON localizas + cgrus + sgrus TAG idxLGS
                    ENDIF
                ENDIF

            CASE THIS.this_nTipoRelatorio = 4
                *-- Estoque por Localizacao (SigMvesl)
                loc_cSQL = "SELECT a.*, b.DPros, b.Reffs, b.PVens, b.PCuss, b.CGrus, b.SGrus " + ;
                    "FROM SigMvesl a, SigCdpro b " + ;
                    "WHERE a.CPros = b.Cpros AND " + loc_cWhere2 + ;
                    "ORDER BY a.grupos, a.estos, a.locals, a.cpros"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsImpressao")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao executar query estoque por localiza" + CHR(231) + CHR(227) + "o"
                    loc_lOK = .F.
                ENDIF
            ENDCASE

            IF loc_lOK
                SELECT CsImpressao
                GO TOP

                *-- Enriquece com descricoes de nivel 3 para tipos 5 e 6
                IF INLIST(THIS.this_nTipoRelatorio, 5, 6)
                    SELECT CsImpressao
                    SCAN
                        loc_cNvl3Local = SUBSTR(CsImpressao.localizas, 5, 2)
                        IF !EMPTY(loc_cNvl3Local) .AND. USED("csNivel3")
                            SELECT csNivel3
                            LOCATE FOR Cods = loc_cNvl3Local
                            IF FOUND()
                                REPLACE Descrs WITH csNivel3.Descs IN CsImpressao
                            ENDIF
                        ENDIF
                        SELECT CsImpressao
                    ENDSCAN
                ENDIF

                *-- Indexa para ordenacao por nivel
                SELECT CsImpressao
                INDEX ON localizas TAG localizas
                INDEX ON SUBSTR(localizas, 3, 2) TAG Nivel2s
                INDEX ON SUBSTR(localizas, 5, 2) TAG Nivel3s
                INDEX ON SUBSTR(localizas, 7, 4) TAG Nivel4s
                GO TOP

                *-- Define ordenacao conforme selecao do usuario
                DO CASE
                CASE THIS.this_nOrdem = 1
                    SET ORDER TO localizas
                CASE THIS.this_nOrdem = 2
                    SET ORDER TO Nivel2s
                CASE THIS.this_nOrdem = 3
                    SET ORDER TO Nivel3s
                CASE THIS.this_nOrdem = 4
                    SET ORDER TO Nivel4s
                ENDCASE
                GO TOP IN CsImpressao

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria cursor csCabecalho com informacoes do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_cTit, loc_cSub, loc_cSub2, loc_cCep, loc_cChr
        loc_cChr = CHR(13) + CHR(10)

        loc_cTit = "Relat" + CHR(243) + "rio de Estoque Por Localiza" + CHR(231) + CHR(227) + "o"

        loc_cSub = "Empresa: " + ALLTRIM(THIS.this_cEmpresa) + "-" + ALLTRIM(THIS.this_cDEmpresa) + loc_cChr + ;
            "Grupo: " + ALLTRIM(THIS.this_cGrupo) + "-" + ALLTRIM(THIS.this_cDGrupo) + loc_cChr + ;
            IIF(!EMPTY(THIS.this_cConta), ;
                "Conta: " + ALLTRIM(THIS.this_cConta) + "-" + ALLTRIM(THIS.this_cDConta) + loc_cChr, "") + ;
            "Localiza" + CHR(231) + CHR(227) + "o: " + ;
            IIF(EMPTY(THIS.this_cLocal), "Global", ALLTRIM(THIS.this_cLocal) + "-" + ALLTRIM(THIS.this_cDLocal))

        loc_cSub2 = "Grande Grupo: " + ;
            IIF(EMPTY(THIS.this_cCSGru), "Global", ALLTRIM(THIS.this_cCSGru) + "-" + ALLTRIM(THIS.this_cDSGru)) + loc_cChr + ;
            "Grupo Produto: " + ;
            IIF(EMPTY(THIS.this_cCgru), "Global", ALLTRIM(THIS.this_cCgru) + "-" + ALLTRIM(THIS.this_cDgru)) + loc_cChr + ;
            "Subgrupo: " + ;
            IIF(EMPTY(THIS.this_cCSubG), "Global", ALLTRIM(THIS.this_cCSubG) + "-" + ALLTRIM(THIS.this_cDSubG)) + loc_cChr + ;
            "Grupo de Venda: " + ;
            IIF(EMPTY(THIS.this_cCol), "Global", ALLTRIM(THIS.this_cCol) + "-" + ALLTRIM(THIS.this_cDCol)) + loc_cChr + ;
            "Fornecedor: " + ;
            IIF(EMPTY(THIS.this_cForn), "Global", ALLTRIM(THIS.this_cForn) + "-" + ALLTRIM(THIS.this_cDForn))

        loc_cCep = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        IF USED("cursor_4c_CrSigCdEmp")
            SELECT cursor_4c_CrSigCdEmp
            GO TOP
            IF !EOF()
                IF !EMPTY(ALLTRIM(cursor_4c_CrSigCdEmp.razas))
                    loc_cCep = loc_cCep + "-" + ALLTRIM(cursor_4c_CrSigCdEmp.razas)
                ENDIF
            ENDIF
        ENDIF

        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        CREATE CURSOR csCabecalho ;
            (titulo C(100), subtitulo C(150), subtitulo2 C(150), empresa C(80))
        INSERT INTO csCabecalho (titulo, subtitulo, subtitulo2, empresa) ;
            VALUES (loc_cTit, loc_cSub, loc_cSub2, loc_cCep)
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarFRX - Retorna nome do FRX a executar conforme tipo e subtotais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SelecionarFRX()
        LOCAL loc_cFRX
        DO CASE
        CASE THIS.this_nTipoRelatorio = 1
            loc_cFRX = "SigReEt1"
        CASE THIS.this_nTipoRelatorio = 2
            loc_cFRX = "SigReEt2"
        CASE THIS.this_nTipoRelatorio = 3 .AND. THIS.this_nSubTotais = 0
            loc_cFRX = "SigReEt3"
        CASE THIS.this_nTipoRelatorio = 3 .AND. THIS.this_nSubTotais = 1
            loc_cFRX = "SigReEt5"
        CASE THIS.this_nTipoRelatorio = 4
            loc_cFRX = "SigReEt4"
        CASE THIS.this_nTipoRelatorio = 5
            loc_cFRX = "SigReEt6"
        CASE THIS.this_nTipoRelatorio = 6
            loc_cFRX = "SigReEt7"
        OTHERWISE
            loc_cFRX = "SigReEt1"
        ENDCASE
        RETURN loc_cFRX
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFRX, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFRX = THIS.SelecionarFRX()
                REPORT FORM (loc_cFRX) TO PRINT PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFRX, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFRX = THIS.SelecionarFRX()
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Prepara dados e imprime direto na impressora padrao (sem dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso, loc_cFRX, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFRX = THIS.SelecionarFRX()
                REPORT FORM (loc_cFRX) TO PRINT NOCONSOLE
                THIS.RegistrarAuditoria("DOCUMENTO")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Documento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao do relatorio executado.
    * Em BO de relatorio, compoe a chave com empresa+grupo+tipo para auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     "T" + ALLTRIM(STR(THIS.this_nTipoRelatorio))
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio no LogAuditoria.
    * Reportos sao apenas-leitura: a auditoria captura quem rodou e quando.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") == "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Operacao, Tabela, ChaveRegistro) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL("SigReEtl") + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL para BO de relatorio.
    * Stub para compatibilidade com pipeline de migracao.
    * Relatorios obtem dados via PrepararDados() agregando multiplas tabelas
    * (SigOpEtq, SigMvesl, SigCdPro, SigCdEmp, SigCdPam, SigLcNv1..4).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "CarregarDoCursor n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel para relat" + ;
                                  CHR(243) + "rio de Estoque por Localiza" + ;
                                  CHR(231) + CHR(227) + "o"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Stub para compatibilidade com pipeline de migracao.
    * A auditoria de execucao eh registrada por RegistrarAuditoria em
    * Imprimir() e Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Inserir n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + ;
                                  "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Stub para compatibilidade com pipeline de migracao.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Atualizar n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + ;
                                  "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ReverterXML - Processa hierarquia de localizacao a partir de dados XML.
    * Reproduz logica do procedimento reverterxml do form original SIGREETL.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ReverterXML(par_cCursor, par_cNivAnt, par_cCurDest)
        LOCAL loc_nOldSel, loc_cXML, loc_oErro
        loc_nOldSel = SELECT()
        TRY
            IF USED("cursor_4c_Aux")
                USE IN cursor_4c_Aux
            ENDIF

            SELECT (par_cCursor)
            SELECT cidchaves, Cods, Descs, 0 AS Marcas, SPACE(4) AS Codigo ;
                FROM (par_cCursor) ;
                WHERE 1=0 ;
                INTO CURSOR cursor_4c_Aux READWRITE

            SELECT (par_cCursor)
            GO TOP

            SCAN
                loc_cXML = NVL(&par_cCursor..Nivel, "")
                ZAP IN cursor_4c_Aux
                IF !EMPTY(loc_cXML)
                    = fXmlToCursor(loc_cXML, "cursor_4c_Aux", .F.)
                    SELECT cursor_4c_Aux
                    SCAN FOR cursor_4c_Aux.Marcas <> 0
                        SELECT (par_cCurDest)
                        APPEND BLANK
                        REPLACE Cods      WITH cursor_4c_Aux.Cods, ;
                                Descs     WITH &par_cCursor..Descs, ;
                                CidChaves WITH cursor_4c_Aux.CidChaves, ;
                                Codigo    WITH &par_cCursor..Cods
                        SELECT cursor_4c_Aux
                    ENDSCAN
                ENDIF
            ENDSCAN

            SELECT (par_cNivAnt)
            GO TOP

            IF USED("cursor_4c_Aux")
                USE IN cursor_4c_Aux
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ReverterXML")
        ENDTRY
        SELECT (loc_nOldSel)
    ENDPROC

ENDDEFINE
