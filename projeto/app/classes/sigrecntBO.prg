*==============================================================================
* SIGRECNTBO.PRG
* Business Object para Relatorio de Contagem por Localizacao
*
* Herda de: RelatorioBase
* Form: Formsigrecnt.prg
* Relatorio original: sigrecnt.SCX / SigReCnt.FRX
*==============================================================================

DEFINE CLASS sigrecntBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCnt"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cBase              = ""
    this_cNvl2              = ""
    this_cNvl3              = ""
    this_cNvl4              = ""
    this_cCods              = ""
    this_nOptLocal          = 0
    this_nOptOrdem          = 0

    *-- Estado / controle
    this_lVisualizaCtg      = .F.
    this_cGrPadVens         = ""

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                     "Contagem por Localiza" + CHR(231) + CHR(227) + "o"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega GrPadVens e cursores de nivel para o form
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cSQL = "SELECT TOP 1 GrPadVens FROM SigCdPam " + ;
                           "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_LocalPam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrPadVens = ALLTRIM(NVL(cursor_4c_LocalPam.GrPadVens, ""))
                    ENDIF
                ENDIF

                IF EMPTY(THIS.this_cGrPadVens)
                    THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores " + ;
                        "N" + CHR(227) + "o Est" + CHR(225) + " Configurado nos " + ;
                        "Par" + CHR(226) + "metros do Sistema."
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv1", "cursor_4c_SigLcNv1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 1"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv2", "cursor_4c_SigLcNv2")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 2"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv3", "cursor_4c_SigLcNv3")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 3"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv4", "cursor_4c_SigLcNv4")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 4"
                    EXIT
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida parametros obrigatorios antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dData)
            THIS.this_cMensagemErro = "Data " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio de contagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_lcLocalizacao, loc_lcBase, loc_lcNvl2, loc_lcNvl3, loc_lcNvl4
        LOCAL loc_lcVends, loc_lnLocal, loc_lnOrdem, loc_lcCods
        LOCAL loc_cDtI, loc_cDtF
        LOCAL loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2
        LOCAL loc_lcNvl3Tmp
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF !THIS.ValidarFiltros()
                    EXIT
                ENDIF

                loc_lcBase        = ALLTRIM(THIS.this_cBase)
                loc_lcNvl2        = ALLTRIM(THIS.this_cNvl2)
                loc_lcNvl3        = ALLTRIM(THIS.this_cNvl3)
                loc_lcNvl4        = ALLTRIM(THIS.this_cNvl4)
                loc_lcLocalizacao = loc_lcBase + loc_lcNvl2 + loc_lcNvl3 + loc_lcNvl4
                loc_lcVends       = ALLTRIM(THIS.this_cConta)
                loc_lnLocal       = THIS.this_nOptLocal
                loc_lnOrdem       = THIS.this_nOptOrdem
                loc_lcCods        = ALLTRIM(THIS.this_cCods)

                loc_cDtI = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 00:00:00', 120)"
                loc_cDtF = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 23:59:59', 120)"

                IF USED("csRel")
                    USE IN csRel
                ENDIF
                IF USED("crRel")
                    USE IN crRel
                ENDIF
                IF USED("crTmpLocal")
                    USE IN crTmpLocal
                ENDIF
                IF USED("crSigCdCnl")
                    USE IN crSigCdCnl
                ENDIF
                IF USED("csTotLocal")
                    USE IN csTotLocal
                ENDIF
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF

                CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

                loc_lcEmpresa = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

                loc_lcTitulo  = "Rela" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
                loc_lcTitulo2 = IIF(!EMPTY(THIS.this_cConta), ;
                    "Vendedor - " + THIS.this_cConta + " " + THIS.this_cDConta, "")
                INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                    VALUES (loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2)

                *-- Contagens realizadas (sigcdcnl + sigcdcni)
                loc_cSQL = "SELECT a.cods, a.datas, a.vends, a.emps, b.locals, b.qtds, b.estoque " + ;
                           "FROM sigcdcnl a " + ;
                           "JOIN sigcdcni b ON a.cods = b.cods " + ;
                           "WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF

                IF !EMPTY(loc_lcCods)
                    loc_cSQL = loc_cSQL + " AND A.Cods = " + EscaparSQL(loc_lcCods)
                ENDIF
                IF !EMPTY(loc_lcVends)
                    loc_cSQL = loc_cSQL + " AND A.Vends = " + EscaparSQL(loc_lcVends)
                ENDIF
                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND b.locals LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnl")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar contagens."
                    EXIT
                ENDIF

                SELECT crSigCdCnl
                INDEX ON Locals TAG Locals
                GO TOP

                IF RECCOUNT("crSigCdCnl") = 0
                    THIS.this_cMensagemErro = "Nenhuma contagem encontrada para os filtros informados."
                    EXIT
                ENDIF

                *-- Estoque por localizacao (SigOpEtq UNION ALL SigMvesl)
                loc_cSQL = "SELECT localizas, grupos, contas, empos, Sum(Qtde) AS qtde, " + ;
                           "CONVERT(NUMERIC(5,0), 0) AS QtdCtg " + ;
                           "FROM (" + ;
                           " SELECT etq.localizas, etq.grupos, etq.contas, etq.empos, COUNT(1) AS qtde " + ;
                           " FROM SigOpEtq etq " + ;
                           " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;
                           "  ON b.cpros = etq.cpros " + ;
                           " WHERE etq.empos = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND etq.contas NOT IN ('15000100','15000141') " + ;
                           " GROUP BY etq.localizas, etq.grupos, etq.contas, etq.empos " + ;
                           " UNION ALL " + ;
                           " SELECT a.locals, a.grupos, a.estos, a.emps, SUM(sqtds) AS Total " + ;
                           " FROM SigMvesl a, SigCdpro b " + ;
                           " WHERE a.CPros = b.Cpros " + ;
                           " AND a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.estos NOT IN ('15000100','15000141') " + ;
                           " AND a.cpros + a.locals NOT IN " + ;
                           "  (SELECT cpros + localizas FROM sigopetq) " + ;
                           " GROUP BY a.locals, a.grupos, a.estos, a.emps" + ;
                           ") sub WHERE Grupos <> SPACE(10)"

                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND localizas LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_cSQL = loc_cSQL + ;
                           " GROUP BY localizas, grupos, contas, empos" + ;
                           " HAVING SUM(qtde) <> 0"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLocal")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar estoque por localiza" + ;
                                              CHR(231) + CHR(227) + "o."
                    EXIT
                ENDIF

                *-- Filtra crTmpLocal: manter apenas localizacoes com contagem
                SELECT crTmpLocal
                GO TOP
                SCAN
                    IF !SEEK(crTmpLocal.localizas, "crSigCdCnl", "Locals")
                        DELETE
                        LOOP
                    ENDIF
                    SELECT crTmpLocal
                ENDSCAN

                SELECT Localizas, SUM(Qtde) AS Qtds ;
                    FROM crTmpLocal WHERE 0=0 ;
                    GROUP BY Localizas ;
                    INTO CURSOR csTotLocal READWRITE

                IF RECCOUNT("csTotLocal") = 0
                    THIS.this_cMensagemErro = "Nenhum estoque encontrado para as " + ;
                        "localiza" + CHR(231) + CHR(245) + "es contadas."
                    EXIT
                ENDIF

                SELECT csTotLocal
                INDEX ON Localizas TAG Locals
                GO TOP

                *-- Gera cursor de resultado conforme OptLocal
                DO CASE
                CASE loc_lnLocal = 1
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        FULL OUTER JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 2
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crSigCdCnl a ;
                        LEFT JOIN crTmpLocal b ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 3
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) = 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 4
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> ;
                            IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) ;
                        INTO CURSOR csRel READWRITE
                ENDCASE

                *-- Agrega resultado final com campos de nivel decompostos
                SELECT Datas, Locals, Vends, Empos, Localizas, ;
                    SUM(Qtds) AS Qtds, SUM(Qtde) AS Qtde, ;
                    SPACE(100) AS Descr, ;
                    LEFT(Locals, 2) AS Nivel1s, ;
                    SUBSTR(Locals, 3, 2) AS Nivel2s, ;
                    SUBSTR(Locals, 5, 2) AS Nivel3s, ;
                    SUBSTR(Locals, 7, 3) AS Nivel4s ;
                    FROM csRel ;
                    GROUP BY Datas, Locals, Vends, Empos, Localizas ;
                    INTO CURSOR crRel READWRITE

                *-- Enriquece descricao com nivel 3
                IF !USED("cursor_4c_SigLcNv3")
                    SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigLcNv3", "cursor_4c_SigLcNv3")
                ENDIF

                SELECT crRel
                INDEX ON Vends + Locals TAG Locals
                GO TOP
                SCAN
                    loc_lcNvl3Tmp = SUBSTR(crRel.Locals, 5, 2)
                    IF !EMPTY(loc_lcNvl3Tmp)
                        SELECT cursor_4c_SigLcNv3
                        LOCATE FOR ALLTRIM(Cods) = ALLTRIM(loc_lcNvl3Tmp)
                        IF FOUND()
                            REPLACE Descr WITH ALLTRIM(cursor_4c_SigLcNv3.Descs) IN crRel
                        ENDIF
                    ENDIF
                    SELECT crRel
                ENDSCAN

                *-- Aplica ordenacao final
                SELECT crRel
                DO CASE
                CASE loc_lnOrdem = 1
                    INDEX ON Locals TAG Locals
                CASE loc_lnOrdem = 2
                    INDEX ON Nivel2s TAG Nivel2s
                CASE loc_lnOrdem = 3
                    INDEX ON Nivel3s TAG Nivel3s
                CASE loc_lnOrdem = 4
                    INDEX ON Nivel4s TAG Nivel4s
                ENDCASE
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e exporta para planilha Excel
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = PUTFILE("Exportar para Excel", ;
                    "contagem_localizacao", "xls")
                IF !EMPTY(loc_cArquivo)
                    SELECT crRel
                    COPY TO (loc_cArquivo) TYPE XLS
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem, o unico
    * parametro persistido eh GrPadVens, usado nos lookups de vendedor.
    * Retorna .T. se carregou, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
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
    * Contagem por Localizacao eh apenas leitura: consulta SigCdCnl/SigCdCnI/
    * SigOpEtq/SigMvesl e gera preview via REPORT FORM. Retorna .F. para
    * satisfazer contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto pela
    * data, empresa e filtro de localizacao) para fins de auditoria/log.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCNT|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cBase) + ;
                     ALLTRIM(THIS.this_cNvl2) + ;
                     ALLTRIM(THIS.this_cNvl3) + ;
                     ALLTRIM(THIS.this_cNvl4)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de execucao do relatorio na
    * tabela LogAuditoria (Empresa, Usuario, DataHora, Operacao, Detalhes).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave
        loc_lSucesso = .F.
        IF EMPTY(par_cOperacao)
            par_cOperacao = "VISUALIZAR"
        ENDIF
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Tabela, ChaveRegistro, Operacao, DadosNovos) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("Relatorio_Contagem") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cTituloRelatorio) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
