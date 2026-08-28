*==============================================================================
* SIGRECGCBO.PRG
* Business Object para Relatorio Generico de Compras
* Original: SigReCgc.SCX (frmrelatorio)
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS SigReCgcBO AS RelatorioBase

    *-- Propriedades padrao herdadas (sobrescritas)
    this_cTabela          = "SigMvCpv"
    this_cCampoChave      = ""
    this_cMensagemErro    = ""

    *-- Propriedades de filtro (populadas pelo form via FormParaRelatorio)
    *-- Equivalente a ThisForm.getDtIni.Value
    this_dDtIni           = {}
    *-- Equivalente a ThisForm.getDtFin.Value
    this_dDtFin           = {}
    *-- Equivalente a ThisForm.optDatas.Value (1=Data Emissao, 2=Vencimento)
    this_nOptDatas        = 1

    *-- Parametros recebidos do form chamador (pGru, pCon do Init original)
    this_cGrupo           = ""
    this_cConta           = ""

    *-- Caminho do FRX e titulo do relatorio
    this_cArquivoFRX      = ""
    this_cTituloRelatorio = "RELAT" + CHR(211) + "RIO GEN" + CHR(201) + "RICO DE COMPRAS"

    *-- Cursores utilizados pelo relatorio
    this_cCursorDados     = "TmpRel"
    this_cCursorCabecalho = "CsCabecalho"
    this_cCursorMoedas    = "TmpMoe"
    this_cCursorTotal     = "CsTotal"

    *-- Estado interno
    this_lDadosCarregados = .F.

    *--------------------------------------------------------------------------
    * Init - Construtor do BO
    * Define caminho do FRX (resolvido em runtime via gc_4c_CaminhoReports)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            IF TYPE("gc_4c_CaminhoReports") = "C"
                THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReCgc.frx"
            ELSE
                THIS.this_cArquivoFRX = "reports\SigReCgc.frx"
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores para o relatorio (equivale a processamento)
    * 1. Obtem empresa (SigCdEmp)
    * 2. Obtem descricao da conta (SigCdCli.rclis)
    * 3. Cria CsCabecalho com titulo/subtitulo/empresa/periodo
    * 4. SQLEXEC SigMvCpv filtrado por Datas ou Vencs
    * 5. GROUP BY moedas -> TmpMoe com soma por moeda
    * 6. Formata total acumulado em CsTotal (memo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lcDatas, loc_lcCampData, loc_lcEmpresa, loc_lcCon
        LOCAL loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo
        LOCAL loc_nValores, loc_cMoedas

        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""

            *-- Tipo de data (D=Emissao, V=Vencimento)
            loc_lcDatas    = IIF(THIS.this_nOptDatas = 1, "D", "V")
            loc_lcCampData = IIF(THIS.this_nOptDatas = 1, "Datas", "Vencs")

            *-- Razao social da empresa via SigCdEmp
            loc_lcEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                       EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRecGcEmp") > 0
                SELECT cursor_4c_SigRecGcEmp
                IF !EOF()
                    loc_lcEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                                    " - " + ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_SigRecGcEmp
            ENDIF

            *-- Descricao da conta (iclis/rclis de SigCdCli)
            loc_lcCon = ""
            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cSQL = "SELECT TOP 1 rclis FROM SigCdCli WHERE iclis = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cConta))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRecGcCli") > 0
                    SELECT cursor_4c_SigRecGcCli
                    IF !EOF()
                        loc_lcCon = " - " + ALLTRIM(rclis)
                    ENDIF
                    USE IN cursor_4c_SigRecGcCli
                ENDIF
            ENDIF

            *-- Monta strings do cabecalho (CHR() para acentos - regra VFP9)
            loc_lcTitulo  = "RELAT" + CHR(211) + "RIO GEN" + CHR(201) + "RICO DE COMPRAS"
            loc_lcSubTit  = "GRUPO : " + ALLTRIM(THIS.this_cGrupo) + ;
                            "/CONTA : " + ALLTRIM(THIS.this_cConta) + loc_lcCon
            loc_lcPeriodo = "PER" + CHR(205) + "ODO DE " + DTOC(THIS.this_dDtIni) + ;
                            " " + CHR(224) + " " + DTOC(THIS.this_dDtFin)

            *-- Cursor de cabecalho
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (Titulo C(200), SubTit C(200), Empresa C(80), Periodo C(35), Datar C(1))
            INSERT INTO (THIS.this_cCursorCabecalho) ;
                (Titulo, SubTit, Empresa, Periodo, Datar) ;
                VALUES (loc_lcTitulo, loc_lcSubTit, loc_lcEmpresa, loc_lcPeriodo, loc_lcDatas)

            *-- Dados do historico filtrados por data via SQLEXEC
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            loc_cSQL = "SELECT *, 'X' AS X FROM SigMvCpv" + ;
                       " WHERE " + loc_lcCampData + ;
                       " BETWEEN " + FormatarDataSQL(THIS.this_dDtIni) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDtFin) + ;
                       " ORDER BY " + loc_lcCampData
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de SigMvCpv"
                loc_lSucesso = .F.
            ENDIF

            *-- Totais por moeda (SELECT nativo no cursor VFP)
            IF USED(THIS.this_cCursorMoedas)
                USE IN (THIS.this_cCursorMoedas)
            ENDIF
            SELECT SUM(valors) AS valores, moedas ;
                FROM (THIS.this_cCursorDados) ;
                GROUP BY moedas ;
                INTO CURSOR (THIS.this_cCursorMoedas) READWRITE

            *-- Cursor de total acumulado formatado por moeda
            IF USED(THIS.this_cCursorTotal)
                USE IN (THIS.this_cCursorTotal)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorTotal) (Total M(4))
            SELECT (THIS.this_cCursorTotal)
            APPEND BLANK

            *-- Itera TmpMoe montando string formatada de totais
            SELECT (THIS.this_cCursorMoedas)
            GO TOP
            DO WHILE !EOF()
                loc_nValores = valores
                loc_cMoedas  = ALLTRIM(moedas)
                SELECT (THIS.this_cCursorTotal)
                REPLACE Total WITH Total + ;
                    TRANSFORM(loc_nValores, "999,999,999,999.99") + ;
                    " " + loc_cMoedas + CHR(13)
                SELECT (THIS.this_cCursorMoedas)
                SKIP
            ENDDO

            *-- Posiciona no inicio para o REPORT FORM
            SELECT (THIS.this_cCursorDados)
            GO TOP

            THIS.this_lDadosCarregados = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora (COM dialogo de impressora)
    * Equivale a PROCEDURE impressao do original
    *--------------------------------------------------------------------------
    FUNCTION Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm("SigReCgc", "PRINTER_PROMPT", THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    * Equivale a PROCEDURE visualizacao do original
    *--------------------------------------------------------------------------
    FUNCTION Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm("SigReCgc", "PREVIEW", THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores do relatorio se estiverem abertos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorMoedas)
            USE IN (THIS.this_cCursorMoedas)
        ENDIF
        IF USED(THIS.this_cCursorTotal)
            USE IN (THIS.this_cCursorTotal)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Stub para compatibilidade com RelatorioBase.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * BOs de Relatorio populam dados via PrepararDados() -> TmpRel,
    * nao precisam carregar registro individual do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao inserem registros no banco.
    * Operacao real e executada por Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao atualizam registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao excluem registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao geram registros de auditoria
    * Override do RelatorioBase para deixar explicito.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta para arquivo XLS
    *   Equivale ao DocExcel do frmrelatorio framework (Buttons(3)).
    *   NAO valida datas: no original "If This.Value # 3" pula a validacao
    *   para o botao DocExcel (botao 3), reproducindo esse comportamento.
    *--------------------------------------------------------------------------
    FUNCTION ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oShell
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados)
                    loc_cArquivo = ADDBS(SYS(5) + SYS(2003)) + ;
                                   "SigReCgc_" + STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    COPY TO (loc_cArquivo) TYPE XLS
                    IF FILE(loc_cArquivo)
                        loc_oShell = CREATEOBJECT("WScript.Shell")
                        IF VARTYPE(loc_oShell) = "O"
                            loc_oShell.Run(SHORTPATH(loc_cArquivo))
                            loc_oShell = .NULL.
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao criar arquivo Excel"
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ExportarExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm (Pattern #117 helper canonico)
    * - Guard IF FILE(FRX) -> MostrarErro descritivo com o path faltante
    * - Guard cursor vazio -> MsgAviso "Nenhum registro encontrado..." (Erro68)
    * - Isolamento locale (POINT/SEPARATOR/REPORTBEHAVIOR 80) durante REPORT FORM
    * - Restauracao de menu apos preview (Erro63 menu-shrinks)
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    * par_cCursorDados: opcional; se vazio/inexistente, mostra aviso e retorna .F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30/Erro68)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Isolamento de locale + modo de renderizacao (Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
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

        *-- Restaurar menu apos preview (Erro63): REPORT FORM PREVIEW abre toolbar
        *-- propria que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar,
        *-- popups renderizam encolhidos apos preview fechar.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC


    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        PREVIEW NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO PRINTER PROMPT NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta relatorio para arquivo ASCII (Excel) (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "SigReCgc_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOPREVIEW NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
