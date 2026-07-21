*==============================================================================
* SIGRECOGBO.PRG
* Business Object - Relatorio de Comissao por Grupo de Produto
*
* Herda de RelatorioBase
* Formulario original: SIGRECOG.SCX (frmrelatorio)
* Tabelas principais: SigMvCab, SigMvItn, SigCdOpe, SigCdEmp, SigCdCli, SigCmGri, SigCdPro
*==============================================================================

DEFINE CLASS sigrecogBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial      = {}
    this_dDtFinal        = {}

    *-- Filtro de empresa
    this_cEmpresa        = ""
    this_cRazaEmpresa    = ""

    *-- Filtro de vendedor
    this_cVendedor       = ""
    this_cNomeVendedor   = ""

    *-- Filtro de moeda (codigo e descricao)
    this_cCmoeda         = ""
    this_cDmoeda         = ""

    *-- Metadados do relatorio
    this_cCaminhoFRX     = ""
    this_cTitulo         = ""
    *-- Cursor final do relatorio (nome DEVE bater com alias usado no FRX legado)
    this_cCursorDados    = "tempo"

    *--------------------------------------------------------------------------
    * Init - Configura o BO com caminho FRX, titulo e valores iniciais dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        LOCAL loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela      = "SigMvCab"
            THIS.this_cCampoChave  = "empdopnums"
            THIS.this_cCaminhoFRX  = gc_4c_CaminhoReports + "SigReCog.frx"
            THIS.this_cTitulo      = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o por Grupo de Produto"

            THIS.this_dDtInicial    = DATE()
            THIS.this_dDtFinal      = DATE()
            THIS.this_cEmpresa      = ""
            THIS.this_cRazaEmpresa  = ""
            THIS.this_cVendedor     = ""
            THIS.this_cNomeVendedor = ""
            THIS.this_cCmoeda       = ""
            THIS.this_cDmoeda       = ""

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria para a execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = IIF(EMPTY(THIS.this_cEmpresa), "TODAS", ALLTRIM(THIS.this_cEmpresa))
        loc_cChave = loc_cChave + "/" + DTOC(THIS.this_dDtInicial) + ;
                     "/" + DTOC(THIS.this_dDtFinal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, " + ;
                       "Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("SigReCog") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            *-- Auditoria nunca bloqueia operacao principal
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio
    * Replica a PROCEDURE processamento do SIGRECOG.SCX original
    * Gera cursores: cabecalho, sumitens (intermediario), cursor_4c_MvItn, tempo
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo
        LOCAL loc_cEmpresa, loc_cVendedor, loc_cCmoeda
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cWEmpresa, loc_cWVendedor
        LOCAL loc_cCgrus, loc_nComiss, loc_cDopes, loc_cVends
        LOCAL loc_dDatasItn, loc_cEmps, loc_cRazas, loc_cNVens
        LOCAL loc_nTotas, loc_nValos, loc_cMoedas, loc_cEmpDopNums
        LOCAL loc_nTotItes, loc_nFator, loc_nTots, loc_nCot1, loc_nCot2
        LOCAL loc_cChaveGrupo

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.

                loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
                loc_cVendedor = ALLTRIM(THIS.this_cVendedor)
                loc_cCmoeda   = PADR(ALLTRIM(THIS.this_cCmoeda), 3)

                *-- 1. Busca nome da empresa no cabecalho
                loc_cNomeEmpresa = ""
                IF !EMPTY(loc_cEmpresa)
                    loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                               "WHERE Cemps = " + EscaparSQL(loc_cEmpresa)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crCogEmp") > 0 AND ;
                       !EOF("crCogEmp")
                        SELECT crCogEmp
                        loc_cNomeEmpresa = ALLTRIM(Razas)
                    ENDIF
                    IF USED("crCogEmp")
                        USE IN crCogEmp
                    ENDIF
                ENDIF

                loc_cTitulo  = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                               "o de Vendedor por Grupo de Produto"
                loc_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                               DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                               DTOC(THIS.this_dDtFinal)

                *-- 2. Cria cursor de cabecalho do relatorio
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                CREATE CURSOR cabecalho (pNomeEmpresa C(80), pRelTitulo C(80), pPeriodo C(80))
                INSERT INTO cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo)

                *-- 3. Executa query sumitens: soma totas por empdopnums no periodo
                IF USED("sumitens")
                    USE IN sumitens
                ENDIF
                loc_cSQL = "SELECT a.empdopnums, a.datas, " + ;
                           "SUM(b.totas) AS totites " + ;
                           "FROM SigMvCab a " + ;
                           "INNER JOIN SigMvItn b ON b.empdopnums = a.empdopnums " + ;
                           "WHERE a.datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                           " AND a.datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                           " GROUP BY a.empdopnums, a.datas " + ;
                           " ORDER BY a.empdopnums, a.datas"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "sumitens")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (sumitens)"
                    EXIT
                ENDIF
                SELECT sumitens
                INDEX ON empdopnums TAG empdopnums

                *-- 4. Executa query principal: join com comissoes por grupo de produto
                loc_cWEmpresa  = IIF(EMPTY(loc_cEmpresa), "", " AND a.emps = " + EscaparSQL(loc_cEmpresa))
                loc_cWVendedor = IIF(EMPTY(loc_cVendedor), "", " AND a.vends = " + EscaparSQL(loc_cVendedor))

                IF USED("cursor_4c_MvItn")
                    USE IN cursor_4c_MvItn
                ENDIF

                loc_cSQL = "SELECT d.empdopnums AS empdopnums, " + ;
                           "d.totas AS totas, " + ;
                           "d.moedas AS moedas, " + ;
                           "a.dopes AS dopes, " + ;
                           "a.vends AS vends, " + ;
                           "a.datas AS datas, " + ;
                           "a.emps AS emps, " + ;
                           "a.valos AS valos, " + ;
                           "g.cgrus AS cgrus, " + ;
                           "g.comiss AS comiss, " + ;
                           "e.razas AS razas, " + ;
                           "f.rclis AS nvens " + ;
                           "FROM SigMvItn d " + ;
                           "INNER JOIN SigMvCab a ON d.empdopnums = a.empdopnums " + ;
                           "INNER JOIN SigCdOpe b ON a.dopes = b.dopes " + ;
                           "INNER JOIN SigCdEmp e ON e.cemps = a.cemps " + ;
                           "INNER JOIN SigCdCli f ON f.iclis = a.vends " + ;
                           "INNER JOIN SigCdPro h ON d.cpros = h.cpros " + ;
                           "INNER JOIN SigCmGri g ON g.cgrus = h.cgrus " + ;
                           "WHERE a.datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                           " AND a.datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                           " AND b.results = 1 " + ;
                           " AND b.ccomis = 1 " + ;
                           loc_cWEmpresa + ;
                           loc_cWVendedor
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvItn")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_MvItn)"
                    EXIT
                ENDIF

                *-- 5. Cria cursor Tempo: agrupa por cgrus/comiss/dopes/vends/datas/emps
                *--    aplicando conversao de moeda via BuscarCotacao
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                CREATE CURSOR tempo (Cgrus C(3), Comiss N(8,2), Dopes C(20), ;
                                     Vends C(10), Datas D, Emps C(3), ;
                                     Razas C(40), NVens C(50), Tots N(11,2))
                INDEX ON PADR(Cgrus,3) + STR(Comiss,8,2) + PADR(Dopes,20) + ;
                         PADR(Vends,10) + DTOS(Datas) + PADR(Emps,3) TAG grpchave

                SELECT cursor_4c_MvItn
                GO TOP
                SCAN
                    loc_cCgrus      = ALLTRIM(cursor_4c_MvItn.Cgrus)
                    loc_nComiss     = NVL(cursor_4c_MvItn.Comiss, 0)
                    loc_cDopes      = ALLTRIM(cursor_4c_MvItn.Dopes)
                    loc_cVends      = ALLTRIM(cursor_4c_MvItn.Vends)
                    loc_dDatasItn   = CTOD(DTOC(cursor_4c_MvItn.Datas))
                    loc_cEmps       = ALLTRIM(cursor_4c_MvItn.Emps)
                    loc_cRazas      = ALLTRIM(cursor_4c_MvItn.Razas)
                    loc_cNVens      = ALLTRIM(cursor_4c_MvItn.NVens)
                    loc_nTotas      = NVL(cursor_4c_MvItn.Totas, 0)
                    loc_nValos      = NVL(cursor_4c_MvItn.Valos, 0)
                    loc_cMoedas     = PADR(ALLTRIM(NVL(cursor_4c_MvItn.Moedas, "")), 3)
                    loc_cEmpDopNums = ALLTRIM(cursor_4c_MvItn.EmpDopNums)

                    *-- Busca total de itens do documento em sumitens
                    loc_nTotItes = 0
                    SELECT sumitens
                    IF SEEK(PADR(loc_cEmpDopNums, 29), "sumitens", "empdopnums")
                        loc_nTotItes = NVL(sumitens.totites, 0)
                    ENDIF
                    SELECT cursor_4c_MvItn

                    *-- Calcula fator de conversao de moeda
                    IF EMPTY(ALLTRIM(loc_cMoedas)) OR loc_cMoedas = loc_cCmoeda
                        loc_nFator = 1
                    ELSE
                        loc_nCot1  = THIS.BuscarCotacao(ALLTRIM(loc_cMoedas), loc_dDatasItn)
                        loc_nCot2  = IIF(EMPTY(ALLTRIM(loc_cCmoeda)), 1, ;
                                         THIS.BuscarCotacao(ALLTRIM(loc_cCmoeda), loc_dDatasItn))
                        loc_nFator = IIF(loc_nCot2 > 0, loc_nCot1 / loc_nCot2, loc_nCot1)
                    ENDIF

                    *-- Calcula valor de comissao proporcional do item
                    loc_nTots = ROUND(IIF(loc_nTotItes > 0, ;
                                         loc_nTotas / loc_nTotItes, 0) * ;
                                      loc_nValos * loc_nFator, 2)

                    *-- Chave de grupo para SEEK no cursor Tempo
                    loc_cChaveGrupo = PADR(loc_cCgrus, 3) + STR(loc_nComiss, 8, 2) + ;
                                      PADR(loc_cDopes, 20) + PADR(loc_cVends, 10) + ;
                                      DTOS(loc_dDatasItn) + PADR(loc_cEmps, 3)

                    SELECT tempo
                    IF SEEK(loc_cChaveGrupo, "tempo", "grpchave")
                        REPLACE Tots WITH tempo.Tots + loc_nTots IN tempo
                    ELSE
                        INSERT INTO tempo (Cgrus, Comiss, Dopes, Vends, Datas, ;
                                           Emps, Razas, NVens, Tots) ;
                            VALUES (loc_cCgrus, loc_nComiss, loc_cDopes, loc_cVends, ;
                                    loc_dDatasItn, loc_cEmps, ;
                                    loc_cRazas, loc_cNVens, loc_nTots)
                    ENDIF

                    SELECT cursor_4c_MvItn
                ENDSCAN

                *-- Ordena Tempo para o relatorio (Emps, Vends, Cgrus)
                SELECT tempo
                INDEX ON PADR(Emps,3) + PADR(Vends,10) + PADR(Cgrus,3) TAG relchave
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Preparar Dados do Relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Comissao por Grupo de
    * Produto nao ha parametros persistidos: as datas iniciam em DATE() e os
    * demais filtros ficam vazios para selecao via lookup. Mantido por
    * contrato (validador da pipeline e RelatorioBase).
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
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Comissao por Grupo de Produto eh apenas leitura: consulta SigMvCab,
    * SigMvItn, SigCmGri e gera preview/impressao via REPORT FORM. Retorna
    * .F. para satisfazer o contrato de BO e sinalizar que a operacao nao
    * se aplica a este BO.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Comiss" + CHR(227) + "o por Grupo de Produto (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Ver observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Comiss" + CHR(227) + "o por Grupo de Produto (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores criados por PrepararDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursores()
        IF USED("cabecalho")
            USE IN cabecalho
        ENDIF
        IF USED("sumitens")
            USE IN sumitens
        ENDIF
        IF USED("tempo")
            USE IN tempo
        ENDIF
        IF USED("cursor_4c_MvItn")
            USE IN cursor_4c_MvItn
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e gera documento (exporta para impressora)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER NOCONSOLE
                THIS.RegistrarAuditoria("EXPORTAR")
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMoedas - Carrega SigCdMoe em cursor para uso nos lookups do form
    * Retorna .T. se sucesso, cursor disponivel como "cursor_4c_Moedas"
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMoedas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Moedas")
                USE IN cursor_4c_Moedas
            ENDIF
            loc_cSQL = "SELECT cmoes, dmoes, cotas, datatrans, fmults, " + ;
                       "nordrels, disfpres, valadics, grumoes, moeqs, " + ;
                       "qtdeqs, submoes " + ;
                       "FROM SigCdMoe " + ;
                       "ORDER BY cmoes, dmoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moedas")
            IF loc_nResult > 0
                SELECT cursor_4c_Moedas
                INDEX ON cmoes TAG cmoes
                INDEX ON dmoes TAG dmoes
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar moedas"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Carregar Moedas")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca taxa de cambio da moeda para a data informada
    * Substitui fBuscarCotacao() do sistema legado
    * Tabela: SigCdCot (cmoes, datas, horas, valos)
    * Retorna 1.0 se moeda nao encontrada (fallback seguro)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nTaxa, loc_cSQL, loc_nResult, loc_cMoeda, loc_cFiltroData

        loc_nTaxa  = 1.0
        loc_cMoeda = ALLTRIM(par_cMoeda)

        IF EMPTY(loc_cMoeda) OR loc_cMoeda = "R"
            RETURN loc_nTaxa
        ENDIF

        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            loc_cFiltroData = "datas <= GETDATE()"
        ELSE
            loc_cFiltroData = "datas <= DATEADD(day, 1, " + FormatarDataSQL(par_dData) + ")"
        ENDIF

        loc_cSQL = "SELECT cmoes, valos FROM SigCdCot " + ;
                   "WHERE " + loc_cFiltroData + ;
                   " ORDER BY cmoes, datas DESC, horas DESC"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CogCot")
        IF loc_nResult > 0 AND !EOF("cursor_4c_CogCot")
            SELECT cursor_4c_CogCot
            LOCATE FOR ALLTRIM(cmoes) = loc_cMoeda
            IF FOUND() AND NVL(valos, 0) > 0
                loc_nTaxa = valos
            ENDIF
        ENDIF

        IF USED("cursor_4c_CogCot")
            USE IN cursor_4c_CogCot
        ENDIF

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE
