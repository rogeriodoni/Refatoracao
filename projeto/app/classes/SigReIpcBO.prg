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

                REPORT FORM (gc_4c_CaminhoReports + "RelSigReIpc.frx") PREVIEW NOCONSOLE
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

                REPORT FORM (gc_4c_CaminhoReports + "RelSigReIpc.frx") TO PRINTER PROMPT NOCONSOLE
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
