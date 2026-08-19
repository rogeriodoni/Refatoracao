*============================================================================
* crfBO.prg - Business Object para Contagem de Referencia (SigCdCrf)
* Herda de BusinessBase
* Tabela principal: SigCdCrf (cabecalho da contagem)
* Tabela detalhe  : SigCdCri (itens/produtos da contagem)
*============================================================================

DEFINE CLASS crfBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdCrf (cabecalho da contagem)
    *--------------------------------------------------------------------------
    this_cCods      = ""    && PK: Codigo da contagem C(10) - gerado por fGerUniqueKey
    this_cEmps      = ""    && Empresa C(3)
    this_cVends     = ""    && Codigo do vendedor C(10) - FK SigCdCli.Iclis
    this_cDesVends  = ""    && Nome do vendedor - virtual do JOIN com SigCdCli.Rclis
    this_dDatas     = {}    && Data da contagem (Date)
    this_nConferido = 0     && Status: 0=contagem aberta, 1=contagem encerrada
    this_cIdChaves  = ""    && Identificador unico do cabecalho - gerado por fUniqueIds

    *--------------------------------------------------------------------------
    * Propriedades auxiliares para operacao
    *--------------------------------------------------------------------------
    this_cGrPadVens    = ""           && Grupo padrao de vendedores (de SigCdPam.GrPadVens)
    this_cCursorItens  = "csSigCdCri" && Cursor de trabalho (itens vindos de SigMvEst)
    this_cCursorSalvar = "crSigCdCri" && Cursor de gravacao (itens para SigCdCri)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCrf"
            THIS.this_cCampoChave = "Cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "crfBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCods)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista contagens de referencia da empresa
    * par_cFiltro: filtro WHERE opcional (sem a palavra WHERE)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (Cods C(10), Emps C(3), Vends C(10), Datas D, ;
                         Conferido N(1,0), cIdChaves C(10), DesVends C(50))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                           " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                           " FROM SigCdCrf a" + ;
                           " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                           " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Datas DESC, a.Cods"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "crfBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega contagem pelo codigo Cods
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                       " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                       " FROM SigCdCrf a" + ;
                       " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Contagem n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarPorCodigo")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "crfBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCods      = TratarNulo(Cods,      "C")
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_cVends     = TratarNulo(Vends,     "C")
                THIS.this_cDesVends  = TratarNulo(DesVends,  "C")
                THIS.this_dDatas     = TratarNulo(Datas,     "D")
                THIS.this_nConferido = TratarNulo(Conferido, "N")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "crfBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigoContagem - Gera proximo codigo numerico para SigCdCrf
    *==========================================================================
    PROTECTED FUNCTION GerarCodigoContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nProxId
        loc_lSucesso = .F.
        loc_nProxId  = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Cods)) AS BIGINT)), 0) + 1" + ;
                       " AS NextID FROM SigCdCrf WHERE ISNUMERIC(Cods) = 1"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxId")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_MaxId") > 0
                SELECT cursor_4c_MaxId
                loc_nProxId = TratarNulo(NextID, "N")
                IF loc_nProxId < 1
                    loc_nProxId = 1
                ENDIF
            ENDIF

            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF

            THIS.this_cCods     = PADL(ALLTRIM(STR(loc_nProxId, 10)), 10, " ")
            THIS.this_cIdChaves = SYS(2015)
            loc_lSucesso = .T.

        CATCH TO loException
            MostrarErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "crfBO.GerarCodigoContagem")
            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - Insere cabecalho em SigCdCrf e itens de csSigCdCri em SigCdCri
    * Usa transacao explicita pois atualiza duas tabelas
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            IF !THIS.GerarCodigoContagem()
                MostrarErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "crfBO.Inserir")
            ELSE
                THIS.this_dDatas     = DATE()
                THIS.this_nConferido = 0

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                    VALUES (
                        <<EscaparSQL(THIS.this_cCods)>>,
                        <<EscaparSQL(THIS.this_cEmps)>>,
                        <<EscaparSQL(THIS.this_cVends)>>,
                        <<FormatarDataSQL(THIS.this_dDatas)>>,
                        <<EscaparSQL(THIS.this_cIdChaves)>>,
                        <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MostrarErro("Erro ao inserir cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Inserir")
                ELSE
                    loc_lSucesso = THIS.SalvarItensContagem()

                    IF loc_lSucesso
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("INSERT")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "crfBO.Inserir")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarItensContagem - Insere cada item de csSigCdCri em SigCdCri
    * Chamado dentro de transacao (Inserir/Atualizar)
    *==========================================================================
    PROTECTED FUNCTION SalvarItensContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        LOCAL loc_cIdChave, loc_cEmps, loc_cGrupos, loc_cEstos
        LOCAL loc_cCpros, loc_nCBars, loc_nQtds, loc_nEstoque, loc_cDescr
        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorItens)
                MostrarErro("Cursor de itens n" + CHR(227) + "o encontrado: " + THIS.this_cCursorItens, "crfBO.SalvarItensContagem")
            ELSE
                loc_lSucesso = .T.

                SELECT (THIS.this_cCursorItens)
                GO TOP

                SCAN WHILE loc_lSucesso
                    loc_cIdChave = SYS(2015)
                    loc_cEmps    = ALLTRIM(TratarNulo(Emps,   "C"))
                    loc_cGrupos  = ALLTRIM(TratarNulo(Grupos, "C"))
                    loc_cEstos   = ALLTRIM(TratarNulo(Estos,  "C"))
                    loc_cCpros   = ALLTRIM(TratarNulo(Cpros,  "C"))
                    loc_nCBars   = TratarNulo(CBars,   "N")
                    loc_nQtds    = TratarNulo(QtdCtg,  "N")
                    loc_nEstoque = TratarNulo(qtde,    "N")
                    loc_cDescr   = LEFT(ALLTRIM(TratarNulo(Descr, "C")), 60)

                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCri (cIdChaves, Cods, Emps, Grupos, Estos, Cpros, CBars, Qtds, Estoque, Descr)
                        VALUES (
                            <<EscaparSQL(loc_cIdChave)>>,
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(loc_cEmps)>>,
                            <<EscaparSQL(loc_cGrupos)>>,
                            <<EscaparSQL(loc_cEstos)>>,
                            <<EscaparSQL(loc_cCpros)>>,
                            <<FormatarNumeroSQL(loc_nCBars, 0)>>,
                            <<FormatarNumeroSQL(loc_nQtds, 2)>>,
                            <<FormatarNumeroSQL(loc_nEstoque, 2)>>,
                            <<EscaparSQL(loc_cDescr)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao salvar item [" + loc_cCpros + "]:" + CHR(13) + CapturarErroSQL(), "crfBO.SalvarItensContagem")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT (THIS.this_cCursorItens)
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar itens:" + CHR(13) + loException.Message, "crfBO.SalvarItensContagem")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Delete+reinsert em SigCdCrf e SigCdCri (mesmo padrao do legado)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            THIS.this_dDatas    = DATE()
            THIS.this_cIdChaves = SYS(2015)

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            *-- Exclui itens existentes
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir itens anteriores:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
            ELSE
                *-- Exclui cabecalho existente
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir cabe" + CHR(231) + "alho anterior:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                ELSE
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                        VALUES (
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(THIS.this_cEmps)>>,
                            <<EscaparSQL(THIS.this_cVends)>>,
                            <<FormatarDataSQL(THIS.this_dDatas)>>,
                            <<EscaparSQL(THIS.this_cIdChaves)>>,
                            <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao regravar cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                    ELSE
                        loc_lSucesso = THIS.SalvarItensContagem()

                        IF loc_lSucesso
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                            loc_lTransacao = .F.
                            THIS.RegistrarAuditoria("UPDATE")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "crfBO.Atualizar")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui contagem (itens + cabecalho) com verificacao
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            *-- Verifica se a contagem esta encerrada (nao pode excluir encerradas)
            IF THIS.this_nConferido = 1
                MsgAviso("Contagem J" + CHR(225) + " Encerrada. Reabra antes de excluir.")
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                    IF loc_nResultado >= 0
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "crfBO.ExecutarExclusao")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega grupo padrao de vendedores de SigCdPam
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .T.
            ELSE
                *-- Erro106: SigCdPam eh tabela de parametros single-row (system-wide),
                *-- nao tem coluna Emps. Legado usa `SELECT GrPadVens FROM SigCdPam` sem WHERE.
                loc_cSQL = "SELECT GrPadVens FROM SigCdPam"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Params")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Params") > 0
                    SELECT cursor_4c_Params
                    GO TOP
                    THIS.this_cGrPadVens = ALLTRIM(TratarNulo(GrPadVens, "C"))

                    IF EMPTY(THIS.this_cGrPadVens)
                        MostrarErro("O Grupo Padr" + CHR(227) + "o de Vendedores n" + CHR(227) + "o est" + ;
                                    CHR(225) + " configurado nos Par" + CHR(226) + "metros do Sistema.", ;
                                    "Configura" + CHR(231) + CHR(227) + "o Incorreta")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    MostrarErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados.", "crfBO.CarregarParametros")
                ENDIF

                IF USED("cursor_4c_Params")
                    USE IN cursor_4c_Params
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar par" + CHR(226) + "metros:" + CHR(13) + loException.Message, "crfBO.CarregarParametros")
            IF USED("cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarProdutosEstoque - Carrega produtos de SigMvEst em csSigCdCri
    * Usado ao iniciar nova contagem (modo INSERIR)
    *==========================================================================
    PROCEDURE CarregarProdutosEstoque()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                CREATE CURSOR (THIS.this_cCursorItens) ;
                    (Emps C(3), Grupos C(10), Estos C(10), cpros C(15), ;
                     qtde N(12,2), QtdCtg N(5,0), Descr C(60), CBars N(15,0))
                loc_lSucesso = .T.
            ELSE
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " CONVERT(numeric(5,0), 0) AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0" + ;
                       " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar produtos do estoque:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarProdutosEstoque")
            ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar estoque:" + CHR(13) + loException.Message, "crfBO.CarregarProdutosEstoque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarItensContagem - Carrega produtos + mescla com itens de SigCdCri
    * Usado ao editar (ALTERAR) ou visualizar (CONSULTAR) contagem existente
    * par_cCodigo      : codigo da contagem (Cods)
    * par_lSoContados  : .T. = mostra apenas itens que foram contados (CONSULTAR)
    *==========================================================================
    PROCEDURE CarregarItensContagem(par_cCodigo, par_lSoContados)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            *-- Query unica: produtos do estoque com QtdCtg ja preenchida de SigCdCri
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " ISNULL(" + ;
                       "   (SELECT TOP 1 i.Qtds FROM SigCdCri i" + ;
                       "    WHERE i.Cods = " + EscaparSQL(par_cCodigo) + ;
                       "    AND i.Cpros = a.cpros AND i.Emps = a.Emps" + ;
                       "    AND i.Grupos = a.Grupos AND i.Estos = a.Estos), 0)" + ;
                       " AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0"

            IF par_lSoContados
                *-- CONSULTAR/Encerrada: filtra apenas itens que existem em SigCdCri
                loc_cSQL = loc_cSQL + ;
                           " AND EXISTS (SELECT 1 FROM SigCdCri cx" + ;
                           " WHERE cx.Cods = " + EscaparSQL(par_cCodigo) + ;
                           " AND cx.Cpros = a.cpros AND cx.Emps = a.Emps" + ;
                           " AND cx.Grupos = a.Grupos AND cx.Estos = a.Estos)"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens da contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarItensContagem")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "crfBO.CarregarItensContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EncerrarContagem - Define Conferido=1 na contagem especificada
    *==========================================================================
    PROCEDURE EncerrarContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 1" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 1
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao encerrar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.EncerrarContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao encerrar:" + CHR(13) + loException.Message, "crfBO.EncerrarContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ReabrirContagem - Define Conferido=0 na contagem especificada
    *==========================================================================
    PROCEDURE ReabrirContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 0" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao reabrir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ReabrirContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao reabrir:" + CHR(13) + loException.Message, "crfBO.ReabrirContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarVendedores - Pesquisa vendedores validos no grupo padrao
    * par_cValor: valor de busca inicial
    * par_cCampo: "Iclis" (por codigo) ou "Rclis" (por nome)
    *==========================================================================
    PROCEDURE BuscarVendedores(par_cValor, par_cCampo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cGrPadVens)
                THIS.CarregarParametros()
            ENDIF

            IF USED("cursor_4c_Vendedores")
                USE IN cursor_4c_Vendedores
            ENDIF

            loc_cSQL = "SELECT a.Iclis, a.Rclis, a.Grupos, a.Situas," + ;
                       " a.Cpfs, a.Inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE NOT b.Coletors = 10" + ;
                       " AND a.Grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND c.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY a.Iclis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Vendedores")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Vendedores
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar vendedores:" + CHR(13) + CapturarErroSQL(), "crfBO.BuscarVendedores")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar vendedores:" + CHR(13) + loException.Message, "crfBO.BuscarVendedores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
