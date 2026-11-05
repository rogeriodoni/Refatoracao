*==============================================================================
* SIGOPFLUBO.PRG
* Business Object para Relatorio de FollowUp de Clientes/Contas
*
* Herda de: RelatorioBase
* Form: FormSIGOPFLU.prg
* Relatorio original: SIGOPFLU.SCX / SigOpFlu.FRX
*==============================================================================

DEFINE CLASS SIGOPFLUBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigOpFlu"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario (Periodo)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro de Grupo (SigCdGcr - cgrus/descrs)
    this_cGrupo             = ""
    this_cDGrupo            = ""

    *-- Filtro de Conta/Cliente (SigCdCli - iclis/rclis)
    this_cConta             = ""
    this_cDConta            = ""

    *-- Opcao de impressao (ChkData do legado)
    this_lImpData           = .F.

    *-- Cabecalho do relatorio (Empresa/Titulo/SubTitulo/ImpData)
    this_cEmpresa           = ""

    *-- Cursores gerados por PrepararDados (nomes identicos ao legado,
    *-- pois o FRX SigOpFlu.frx faz binding por esses aliases)
    this_cCursorCabecalho   = "CsCabecalho"
    this_cCursorDados       = "CsFwUp"

    *--------------------------------------------------------------------------
    * Init - Construtor. Define titulo do relatorio e aliases de cursor.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Impress" + CHR(227) + "o de FollowUp"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Valida filtros, monta cursores CsCabecalho (header do
    * FRX) e CsFwUp (historico de ocorrencias SigCdClh JOIN SigCdCli), nos
    * mesmos aliases/colunas do legado (processamento do SIGOPFLU.SCX).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cGrupo, loc_cConta
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cSubTitulo, loc_dtDataFim
        LOCAL loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            IF EMPTY(THIS.this_dDtInicial)
                THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida !!!"
            ELSE
                IF EMPTY(THIS.this_dDtFinal)
                    THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida !!!"
                ELSE
                    IF THIS.this_dDtFinal < THIS.this_dDtInicial
                        THIS.this_cMensagemErro = "Data Final n" + CHR(227) + "o pode ser maior que a Inicial !!!"
                    ELSE
                        IF EMPTY(THIS.this_cGrupo)
                            THIS.this_cMensagemErro = "Grupo Inv" + CHR(225) + "lido !!!"
                        ELSE

                            loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
                            loc_cConta = ALLTRIM(THIS.this_cConta)

                            *-- Cabecalho do relatorio (Empresa/Titulo/SubTitulo/ImpData)
                            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ;
                                           ALLTRIM(go_4c_Sistema.cEmpresa)
                            loc_cTitulo = ALLTRIM("Relat" + CHR(243) + "rio de FollowUp de " + ;
                                           PROPER(ALLTRIM(THIS.this_cDGrupo)))
                            loc_cSubTitulo = ALLTRIM("Per" + CHR(237) + "odo : " + ;
                                           DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                                           DTOC(THIS.this_dDtFinal))

                            THIS.this_cEmpresa = loc_cEmpresa

                            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                                (Empresa C(80), Titulo C(80), SubTitulo C(80), ImpData L)
                            INSERT INTO (THIS.this_cCursorCabecalho) ;
                                (Empresa, Titulo, SubTitulo, ImpData) ;
                                VALUES (loc_cEmpresa, loc_cTitulo, loc_cSubTitulo, THIS.this_lImpData)

                            *-- Historico de ocorrencias (SigCdClh) no periodo/grupo/conta
                            loc_dtDataFim = DATETIME(YEAR(THIS.this_dDtFinal), ;
                                MONTH(THIS.this_dDtFinal), DAY(THIS.this_dDtFinal), 23, 59, 59)

                            loc_cSQL = "SELECT a.IClis, a.Datas, a.Hists, a.Obs, b.Cpfs, b.RClis " + ;
                                       "FROM SigCdClh a INNER JOIN SigCdCli b ON a.IClis = b.IClis " + ;
                                       "WHERE a.Datas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                                       " AND " + FormatarDataSQL(loc_dtDataFim) + ;
                                       " AND a.Grupos = " + EscaparSQL(loc_cGrupo)

                            IF !EMPTY(loc_cConta)
                                loc_cSQL = loc_cSQL + " AND a.IClis = " + EscaparSQL(loc_cConta)
                            ENDIF

                            loc_cSQL = loc_cSQL + " ORDER BY a.IClis, a.Datas, a.Hists, b.Cpfs, b.RClis"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

                            IF loc_nResultado < 0
                                THIS.this_cMensagemErro = "Erro ao buscar dados de FollowUp." + ;
                                    CHR(13) + CapturarErroSQL()
                            ELSE
                                IF RECCOUNT(THIS.this_cCursorDados) = 0
                                    THIS.this_cMensagemErro = "Nenhum registro encontrado para os filtros informados."
                                ELSE
                                    SELECT (THIS.this_cCursorDados)
                                    GO TOP
                                    loc_lSucesso = .T.
                                ENDIF
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
    * ExecutarReportForm (Pattern #117/#123) - Executa REPORT FORM apenas se
    * o FRX existir; isola SET POINT/SEPARATOR/REPORTBEHAVIOR (FRXs legados
    * Fortyus foram desenhados em modo 80); restaura o menu principal depois
    * do preview (Erro63). par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER".
    * par_cCursorDados eh opcional - se informado e vazio, avisa e sai sem
    * abrir preview em branco.
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
    * Visualizar - Exibe o relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PREVIEW", ;
                    THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia o relatorio para a impressora (com dialogo de escolha)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PRINTER_PROMPT", ;
                    THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta o relatorio para arquivo .xls
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "SigOpFlu_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOCONSOLE ASCII
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

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro/validacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao persiste registro; retorna chave
    * composta dos filtros principais, para fins de auditoria/log.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = IIF(EMPTY(THIS.this_dDtInicial), SPACE(8), DTOS(THIS.this_dDtInicial)) + "|" + ;
                     IIF(EMPTY(THIS.this_dDtFinal), SPACE(8), DTOS(THIS.this_dDtFinal)) + "|" + ;
                     ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios (RelatorioBase nao
    * persiste dados); mantido para compatibilidade com o padrao do pipeline.
    * A carga dos filtros vem do Form (FormParaRelatorio).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel ao relatorio de FollowUp (frmrelatorio nao
    * persiste dados). A acao equivalente eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel ao relatorio de FollowUp. Vide Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
