*==============================================================================
* SIGMVDOCBO.PRG
* Business Object para Relatorio de Emissao do Documento
*
* Herda de: RelatorioBase
* Form: FormSIGMVDOC.prg
* Relatorio original: SIGMVDOC.SCX (frmrelatorio) / SIGCDENT.FRX
*==============================================================================

DEFINE CLASS SIGMVDOCBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SIGCDENT"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario (faixa de Nota Fiscal)
    this_nNotaI             = 0
    this_nNotaF             = 0

    *-- Cursor principal gerado por PrepararDados (nome exigido pelo FRX legado)
    this_cCursorDados       = "crDados"

    *--------------------------------------------------------------------------
    * Init - Configura identificacao e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela           = ""
        THIS.this_cCampoChave       = ""
        THIS.this_cArquivoRelatorio = "SIGCDENT"
        THIS.this_cTituloRelatorio  = "Emiss" + CHR(227) + "o do Documento"
        THIS.this_cCursorDados      = "crDados"
        THIS.this_nNotaI            = 0
        THIS.this_nNotaF            = 0

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Busca os documentos (Notas Fiscais) da faixa informada
    *
    * O SIGMVDOC.SCX legado eh um dialogo generico de impressao (recebe pRep/pTit
    * e espera encontrar um cursor "crDados" ja aberto pelo chamador); nenhum
    * .prg/.scx legado que povoe esse crDados para pRep="SIGCDENT" sobreviveu no
    * acervo (busca exaustiva no Framework e em C:\4install no vieram vazios).
    * A tabela abaixo (SigMvNfi) foi identificada pelo schema: eh a UNICA tabela
    * com coluna nfis char(6) (mesmo tamanho do InputMask "999999" dos campos
    * GetNotaI/GetNotaF) que tambem tem a coluna "impress" (contador de
    * impressao), condizente com "Emissao do Documento".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult, loc_oErro
        LOCAL loc_cEmpresa, loc_cNotaI, loc_cNotaF

        loc_lSucesso = .F.

        TRY
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            IF THIS.this_nNotaI <= 0 OR THIS.this_nNotaF <= 0
                THIS.this_cMensagemErro = "Informe a faixa de Notas Fiscais (inicial e final)."
            ELSE
                IF THIS.this_nNotaI > THIS.this_nNotaF
                    THIS.this_cMensagemErro = "Nota Inicial maior que a Nota Final!"
                ELSE
                    loc_cNotaI = PADL(ALLTRIM(STR(THIS.this_nNotaI, 6, 0)), 6, "0")
                    loc_cNotaF = PADL(ALLTRIM(STR(THIS.this_nNotaF, 6, 0)), 6, "0")

                    IF USED(THIS.this_cCursorDados)
                        USE IN (THIS.this_cCursorDados)
                    ENDIF

                    loc_cWhere = "emps = " + EscaparSQL(loc_cEmpresa) + ;
                        " AND nfis BETWEEN " + EscaparSQL(loc_cNotaI) + ;
                        " AND " + EscaparSQL(loc_cNotaF)

                    loc_cSQL = "SELECT * FROM SigMvNfi WHERE " + loc_cWhere + " ORDER BY nfis"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar documentos: " + CapturarErroSQL()
                    ELSE
                        IF RECCOUNT(THIS.this_cCursorDados) = 0
                            THIS.this_cMensagemErro = "Nenhum documento encontrado para a faixa de notas informada."
                        ELSE
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                            loc_lSucesso = .T.
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
    * ExecutarReportForm (Pattern #117) - Executa REPORT FORM apenas se o FRX
    * existir; isola SET POINT/SEPARATOR/REPORTBEHAVIOR (FRXs legados Fortyus
    * foram desenhados em POINT="." + REPORTBEHAVIOR 80) e restaura o menu
    * principal apos o PREVIEW (Erro63 - _MREPORT corrompe o _MSYSMENU).
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
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
    * Visualizar - Exibe o documento em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PREVIEW", THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o documento com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PRINTER_PROMPT", THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta o documento para planilha Excel via REPORT FORM ASCII
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_cFRX, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFRX = FULLPATH(gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio + ".frx")
                IF NOT FILE(loc_cFRX)
                    MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                        loc_cFRX, "Erro")
                ELSE
                    loc_cArquivo = SYS(5) + CURDIR() + "SigMvDoc_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (loc_cFRX) TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao gerar arquivo Excel."
                    ENDIF
                ENDIF
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
    * ObterChavePrimaria - Identificador da execucao do relatorio (auditoria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "SIGMVDOC|" + ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
            PADL(ALLTRIM(STR(THIS.this_nNotaI, 6, 0)), 6, "0") + "|" + ;
            PADL(ALLTRIM(STR(THIS.this_nNotaF, 6, 0)), 6, "0")
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o cursor de dados do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
