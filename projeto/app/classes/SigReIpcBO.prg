*==============================================================================
* SIGREIPCBO.PRG
* Business Object para SigReIpc - Impress?o da Rela??o de Operacoes
*
* Herda de RelatorioBase
*
* Contexto: Form utilit?rio chamado pelo SIGCDPGR com cursores j? preparados.
*   - TmpLanca : cursor de dados principal (lancamentos)
*   - xPar     : cursor de par?metros
*   - crSigCdEmp: cursor de empresa
*   - crSigCdPgr: cursor de opera??es (contendo Dopes, Numes)
*   - Par?metro Qbols: n?mero de opera??es a imprimir
*==============================================================================

DEFINE CLASS SigReIpcBO AS RelatorioBase

    *-- N?mero de opera??es a imprimir (par?metro recebido pelo form)
    this_nQbols = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Posiciona cursores para o relatorio
    * Cursores TmpLanca/xPar/crSigCdEmp/crSigCdPgr sao preparados pelo form chamador
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("TMPLANCA")
                SELECT TMPLANCA
                GO TOP
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview, uma iteracao por operacao
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117 / #123)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
    *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
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

        RETURN .T.
    ENDPROC

    PROCEDURE Visualizar()
        LOCAL loc_nX, loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            FOR loc_nX = 1 TO THIS.this_nQbols
                loc_cNomeEmpresa = IIF(SEEK(go_4c_Sistema.cCodEmpresa, "crSigCdEmp", "Cemps"), ;
                                       ALLTRIM(crSigCdEmp.Razas), "")
                loc_cRelTitulo = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                 PROPER(ALLTRIM(crSigCdPgr.Dopes)) + "s"
                loc_cPeriodo   = "Opera" + CHR(231) + CHR(227) + "o : " + ;
                                 ALLTRIM(crSigCdPgr.Dopes) + " " + ;
                                 fGerMascara(crSigCdPgr.Numes)

                IF USED("Cabecalho")
                    USE IN Cabecalho
                ENDIF
                CREATE CURSOR Cabecalho (pNomeEmpresa C(80), pRelTitulo C(80), ;
                                         pTipo N(1), pPeriodo C(80))
                INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo, pTipo) ;
                    VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, 1)

                IF USED("xPar")
                    SELECT xPar
                    GO TOP
                ENDIF

                SELECT TMPLANCA
                GO TOP

                THIS.ExecutarReportForm("RelSigReIpc", "PREVIEW")
            ENDFOR
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto na impressora, uma iteracao por operacao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_nX, loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            FOR loc_nX = 1 TO THIS.this_nQbols
                loc_cNomeEmpresa = IIF(SEEK(go_4c_Sistema.cCodEmpresa, "crSigCdEmp", "Cemps"), ;
                                       ALLTRIM(crSigCdEmp.Razas), "")
                loc_cRelTitulo = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                 PROPER(ALLTRIM(crSigCdPgr.Dopes)) + "s"
                loc_cPeriodo   = "Opera" + CHR(231) + CHR(227) + "o : " + ;
                                 ALLTRIM(crSigCdPgr.Dopes) + " " + ;
                                 fGerMascara(crSigCdPgr.Numes)

                IF USED("Cabecalho")
                    USE IN Cabecalho
                ENDIF
                CREATE CURSOR Cabecalho (pNomeEmpresa C(80), pRelTitulo C(80), ;
                                         pTipo N(1), pPeriodo C(80))
                INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo, pTipo) ;
                    VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cPeriodo, 1)

                IF USED("xPar")
                    SELECT xPar
                    GO TOP
                ENDIF

                SELECT TMPLANCA
                GO TOP

                THIS.ExecutarReportForm("RelSigReIpc", "PRINTER_PROMPT")
            ENDFOR
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

ENDDEFINE
