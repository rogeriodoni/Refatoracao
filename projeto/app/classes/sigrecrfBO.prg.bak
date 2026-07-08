*==============================================================================
* SIGRECRFBO.PRG
* Business Object para Relatorio de Contagem por Referencia
*
* Herda de: RelatorioBase
* Form: Formsigrecrf.prg
* Relatorio original: sigrecrf.SCX / SigReCrf.FRX
*==============================================================================

DEFINE CLASS sigrecrfBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCrf"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cCods              = ""
    this_cProduto           = ""
    this_cDsProduto         = ""
    this_cCdGrEstoque       = ""
    this_cDsGrEstoque       = ""
    this_cCdEstoque         = ""
    this_cDsEstoque         = ""
    this_nOptLocal          = 4

    *-- Estado / controle
    this_cGrPadVens         = ""
    this_lAcessoSomentesDif = .F.

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init - Carrega GrPadVens de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de Contagem por Referencia"
        THIS.this_nOptLocal        = 4

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 GrPadVens FROM SigCdPam", ;
                    "cursor_4c_SigrecrfPam")

                IF loc_nResult > 0
                    SELECT cursor_4c_SigrecrfPam
                    IF !EOF()
                        THIS.this_cGrPadVens = ALLTRIM(GrPadVens)
                    ENDIF
                    USE IN cursor_4c_SigrecrfPam
                ENDIF

                IF EMPTY(THIS.this_cGrPadVens)
                    THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores n" + ;
                        CHR(227) + "o est" + CHR(225) + " configurado nos par" + CHR(226) + ;
                        "metros do sistema. Configure antes de prosseguir."
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrfBO.Init")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor crRel para REPORT FORM
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult, loc_oErro
        LOCAL loc_cEmpresa, loc_cVends, loc_cCods, loc_cPro, loc_cGrupo, loc_cConta, loc_nLocal
        LOCAL loc_cNomeEmpresa, loc_cTitulo2

        loc_lSucesso = .F.

        TRY
            loc_cVends   = ALLTRIM(THIS.this_cConta)
            loc_nLocal   = THIS.this_nOptLocal
            loc_cCods    = ALLTRIM(THIS.this_cCods)
            loc_cPro     = ALLTRIM(THIS.this_cProduto)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cConta   = ALLTRIM(THIS.this_cCdEstoque)
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            *-- Limpar cursores de execucao anterior
            IF USED("csRel")
                USE IN csRel
            ENDIF
            IF USED("crRel")
                USE IN crRel
            ENDIF
            IF USED("crTmpCrf")
                USE IN crTmpCrf
            ENDIF
            IF USED("crSigCdCrf")
                USE IN crSigCdCrf
            ENDIF
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            IF USED("csTotLocal")
                USE IN csTotLocal
            ENDIF

            *-- Validar data (obrigatoria exceto para Diferencas - OptLocal=4)
            IF loc_nLocal <> 4 AND EMPTY(THIS.this_dData)
                THIS.this_cMensagemErro = "Data inv" + CHR(225) + "lida!"
            ELSE

            *-- Montar cabecalho do relatorio
            CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

            loc_cNomeEmpresa = loc_cEmpresa
            loc_cTitulo2     = ""

            IF !EMPTY(go_4c_Sistema.cEmpresa)
                loc_cNomeEmpresa = loc_cEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)
            ENDIF

            IF !EMPTY(loc_cVends)
                loc_cTitulo2 = "Vendedor - " + loc_cVends + " " + ALLTRIM(THIS.this_cDConta)
            ENDIF

            INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTituloRelatorio, loc_cTitulo2)

            *--------------------------------------------------------------
            *-- QUERY 1: Contagens - sigcdcrf JOIN sigcdcri
            *--------------------------------------------------------------
            loc_cWhere = "a.Emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(THIS.this_dData)
                loc_cWhere = loc_cWhere + ;
                    " And CAST(a.Datas AS DATE) = " + FormatarDataSQL(THIS.this_dData)
            ENDIF
            IF !EMPTY(loc_cCods)
                loc_cWhere = loc_cWhere + " And A.Cods = " + EscaparSQL(loc_cCods)
            ENDIF
            IF !EMPTY(loc_cVends)
                loc_cWhere = loc_cWhere + " And A.Vends = " + EscaparSQL(loc_cVends)
            ENDIF
            IF !EMPTY(loc_cPro)
                loc_cWhere = loc_cWhere + " And b.cpros = " + EscaparSQL(loc_cPro)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + " And b.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + " And b.estos = " + EscaparSQL(loc_cConta)
            ENDIF

            loc_cSQL = "Select a.cods, a.datas, a.vends, a.emps, " + ;
                       "b.cpros, b.grupos, b.estos, b.qtds, b.estoque " + ;
                       "from sigcdcrf a " + ;
                       "join sigcdcri b on a.cods = b.cods " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCrf")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Tabelas de Contagem por Refer" + CHR(234) + ;
                    "ncia (sigcdcrf/sigcdcri) n" + CHR(227) + "o encontradas ou falha de conex" + ;
                    CHR(227) + "o."
            ELSE

                IF RECCOUNT("crSigCdCrf") = 0
                    THIS.this_cMensagemErro = "Nenhum registro encontrado para os filtros informados."
                ELSE

                    SELECT crSigCdCrf
                    INDEX ON Emps + Grupos + Estos + Cpros TAG Produto
                    GO TOP

                    *--------------------------------------------------------------
                    *-- QUERY 2: Estoque - SigMvEst JOIN SigCdpro/SigCdCli/SigCtCtg
                    *--------------------------------------------------------------
                    loc_cWhere = "a.emps = " + EscaparSQL(loc_cEmpresa)
                    IF !EMPTY(loc_cPro)
                        loc_cWhere = loc_cWhere + " And a.cpros = " + EscaparSQL(loc_cPro)
                    ENDIF
                    IF !EMPTY(loc_cGrupo)
                        loc_cWhere = loc_cWhere + " And a.grupos = " + EscaparSQL(loc_cGrupo)
                    ENDIF
                    IF !EMPTY(loc_cConta)
                        loc_cWhere = loc_cWhere + " And a.estos = " + EscaparSQL(loc_cConta)
                    ENDIF

                    loc_cSQL = "Select a.Emps, a.Grupos, a.Estos, a.cpros, " + ;
                               "sum(sqtds) as qtde, convert(numeric(5,0),0) as QtdCtg, b.dpros as Descr " + ;
                               "From SigMvEst a " + ;
                               "Join SigCdpro b on a.CPros = b.Cpros " + ;
                               "Join SigCdCli c on a.Estos = c.Iclis " + ;
                               "join SigCtCtg d on a.empgruests = d.empresa + d.grupos + d.contas " + ;
                               "Where " + loc_cWhere + ;
                               " And b.cunis = 'UN'" + ;
                               " group by a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros" + ;
                               " Having sum(sqtds) <> 0" + ;
                               " order by a.Emps, a.Grupos, a.Estos, a.cpros"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpCrf")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar estoque (crTmpCrf)"
                    ELSE

                        *-- Remover de crTmpCrf itens ausentes em crSigCdCrf
                        SELECT crTmpCrf
                        GO TOP
                        SCAN
                            IF !SEEK(crTmpCrf.Emps + crTmpCrf.Grupos + crTmpCrf.Estos + crTmpCrf.Cpros, ;
                                     "crSigCdCrf", "Produto")
                                DELETE
                            ENDIF
                            SELECT crTmpCrf
                        ENDSCAN

                        *-- Agregar crTmpCrf por produto
                        SELECT crTmpCrf
                        SELECT Emps, grupos, estos, cpros, Sum(Qtde) As Qtds ;
                            From crTmpCrf ;
                            Where NOT DELETED() ;
                            Group By Emps, grupos, estos, cpros ;
                            Into Cursor csTotLocal READWRITE

                        IF RECCOUNT("csTotLocal") = 0
                            THIS.this_cMensagemErro = "Nenhum item de estoque encontrado para os filtros."
                        ELSE

                            SELECT csTotLocal
                            INDEX ON Emps + Grupos + Estos + Cpros TAG Produtos
                            GO TOP

                            *--------------------------------------------------------------
                            *-- Aplicar filtro Localizacoes (OptLocal 1=Todas 2=Lidos 3=NaoLidos 4=Diferencas)
                            *--------------------------------------------------------------
                            DO CASE
                            CASE loc_nLocal = 1
                                SELECT DISTINCT a.DataS, ;
                                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                                    From crTmpCrf b ;
                                    FULL OUTER JOIN crSigCdCrf a ;
                                    On a.emps = b.emps And a.grupos = b.grupos ;
                                    And a.estos = b.estos And a.cpros = b.cpros ;
                                    Into Cursor csRel READWRITE

                            CASE loc_nLocal = 2
                                SELECT DISTINCT a.DataS, ;
                                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                                    From crSigCdCrf a ;
                                    LEFT JOIN crTmpCrf b ;
                                    On a.emps = b.emps And a.grupos = b.grupos ;
                                    And a.estos = b.estos And a.cpros = b.cpros ;
                                    Where NVL(a.Qtds,0) <> 0 ;
                                    Into Cursor csRel READWRITE

                            CASE loc_nLocal = 3
                                SELECT DISTINCT a.DataS, ;
                                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                                    From crTmpCrf b ;
                                    LEFT JOIN crSigCdCrf a ;
                                    On a.emps = b.emps And a.grupos = b.grupos ;
                                    And a.estos = b.estos And a.cpros = b.cpros ;
                                    Where NVL(a.Qtds,0) = 0 ;
                                    Into Cursor csRel READWRITE

                            CASE loc_nLocal = 4
                                SELECT a.DataS, ;
                                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                                    From crTmpCrf b ;
                                    LEFT JOIN crSigCdCrf a ;
                                    On a.emps = b.emps And a.grupos = b.grupos ;
                                    And a.estos = b.estos And a.cpros = b.cpros ;
                                    Where NVL(a.Qtds,0) <> NVL(b.Qtde,0) ;
                                    Into Cursor csRel READWRITE
                            ENDCASE

                            *-- Agregacao final -> crRel (cursor do REPORT FORM)
                            SELECT DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr, ;
                                Sum(Qtds) As Qtds, Sum(Qtde) As Qtde ;
                                From csRel ;
                                Group By DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr ;
                                Into Cursor crRel READWRITE

                            SELECT crRel
                            INDEX ON Vends + Emps + grupos + estos + cpros TAG Locals
                            GO TOP

                            *-- Limpar cursores intermediarios
                            IF USED("csRel")
                                USE IN csRel
                            ENDIF
                            IF USED("csTotLocal")
                                USE IN csTotLocal
                            ENDIF
                            IF USED("crTmpCrf")
                                USE IN crTmpCrf
                            ENDIF
                            IF USED("crSigCdCrf")
                                USE IN crSigCdCrf
                            ENDIF

                            loc_lSucesso = .T.

                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta relatorio para planilha Excel via REPORT FORM XML
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = SYS(5) + CURDIR() + "SigReCrf_" + ;
                               STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO FILE &loc_cArquivo NOPREVIEW NOCONSOLE ASCII
                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarVendedores - Busca lista de vendedores para lookup no form
    * Popula cursor_4c_SigrecrfVends com iclis, rclis, grupos, situas, Cpfs
    * Filtra por GrPadVens, Emps, acesso do usuario (SigCdAcJ)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarVendedores()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfVends")
                USE IN cursor_4c_SigrecrfVends
            ENDIF

            loc_cSQL = "Select a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs " + ;
                       "From SigCdCli a " + ;
                       "Inner Join SigCdGcr b On a.Grupos = b.Codigos " + ;
                       "And (b.Coletors <> 10 Or (b.Coletors = 10 " + ;
                       "And a.IClis Not In (" + ;
                       "Select Distinct c.Jobs From SigCdAcJ c " + ;
                       "Where c.Jobs Not In (" + ;
                       "Select Distinct d.Jobs From SigCdAcJ d " + ;
                       "Where d.Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                       ")))) " + ;
                       "And a.grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " And a.Inativas <> 2" + ;
                       " And a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfVends")
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar vendedores"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarVendedores")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Busca produto em SigCdPro para lookup no form
    * par_cFiltro: valor digitado
    * par_cTipo:   "C"=por codigo (cpros), "N"=por descricao (dpros)
    * Popula cursor_4c_SigrecrfPro com cpros, dpros
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cFiltro, par_cTipo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCampo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfPro")
                USE IN cursor_4c_SigrecrfPro
            ENDIF

            IF ALLTRIM(par_cTipo) = "C"
                loc_cCampo = "cpros"
            ELSE
                loc_cCampo = "dpros"
            ENDIF

            loc_cSQL = "Select cpros, dpros " + ;
                       "From SigCdPro " + ;
                       "Where " + loc_cCampo + " LIKE " + ;
                       EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                       " Order By dpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfPro")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfPro
                GO TOP
                loc_lSucesso = !EOF()
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar produto"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarProduto")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem por Referencia,
    * o unico parametro persistido eh GrPadVens, usado no lookup de vendedor.
    * Retorna .T. se carregou com sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                IF TYPE("&par_cAliasCursor..GrPadVens") = "C"
                    THIS.this_cGrPadVens = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrPadVens"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Contagem por Referencia eh apenas leitura: consulta SigCdCrf/SigCdCrI/
    * SigMvEst e gera preview via REPORT FORM. Retorna .F. para satisfazer
    * contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto por
    * data, empresa, vendedor e filtro de localizacao) para fins de auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCRF|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + ;
                     ALLTRIM(THIS.this_cCods) + "|" + ;
                     ALLTRIM(THIS.this_cProduto) + "|" + ;
                     ALLTRIM(THIS.this_cCdGrEstoque) + "|" + ;
                     ALLTRIM(THIS.this_cCdEstoque) + "|" + ;
                     TRANSFORM(THIS.this_nOptLocal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crRel")
            USE IN crRel
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("cursor_4c_SigrecrfVends")
            USE IN cursor_4c_SigrecrfVends
        ENDIF
        IF USED("cursor_4c_SigrecrfPro")
            USE IN cursor_4c_SigrecrfPro
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
