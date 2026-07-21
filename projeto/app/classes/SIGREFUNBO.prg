*==============================================================================
* SIGREFUNBO.PRG
* Business Object para Relatorio de Tubos Fundicao
*
* Herda de: RelatorioBase
* Entidade: SIGREFUN (Relacao de tubos fundicao)
* Tabelas principais: SigCdFun, SigCdFud, SigCdCor
*==============================================================================

DEFINE CLASS SIGREFUNBO AS RelatorioBase

    *-- Propriedades base (override)
    this_cTabela        = "SigCdFun"
    this_cCampoChave    = "Codigos"
    this_cMensagemErro  = ""

    *-- Filtros do relatorio (mapeados dos controles do form)
    this_nFundI         = 0     && GetFundi - No. Fundicao inicio (InputMask "999999")
    this_nFundF         = 0     && GetFundf - No. Fundicao fim   (InputMask "999999")
    this_lImpObs        = .F.   && ImpObs - Imprimir observacao do item

    *-- Controle interno do relatorio
    this_cNomeRelatorio   = "SIGREFUN"
    this_cCursorDados     = "Relatorio"    && Nome exigido pelo FRX legado
    this_cTituloRelatorio = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de tubos fundicao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o tubos fundi" + CHR(231) + CHR(227) + "o"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros obrigatorios antes de processar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_nFundI) OR EMPTY(THIS.this_nFundF)
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero de fundi" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Busca e monta dados do relatorio de tubos fundicao
    * Logica original: SigReFun.processamento
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpresa, loc_cTitulo2, loc_nCod, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Cursor de cabecalho para o relatorio
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), ;
                                        Titulo2 C(200), Figura C(10), ImpObs L)

            *-- Nome da empresa a partir do objeto sistema
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            loc_cTitulo2 = "Fundi" + CHR(231) + CHR(227) + "o - " + ;
                           ALLTRIM(STR(THIS.this_nFundI, 6)) + " at" + CHR(233) + " " + ;
                           ALLTRIM(STR(THIS.this_nFundF, 6))

            SELECT csCabecalho
            INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2, ImpObs) ;
                VALUES (loc_cEmpresa, THIS.this_cTituloRelatorio, loc_cTitulo2, THIS.this_lImpObs)

            *-- Cursor de trabalho para montagem do relatorio
            IF USED("Relatorio")
                USE IN Relatorio
            ENDIF
            CREATE CURSOR Relatorio (Codigos N(6), Tubos N(2), bCeras N(12,2), Bases N(12,2), ;
                                      Ceras N(12,2), Metals N(12,2), CodCors C(4), ;
                                      Obss M, Datas D, ObsG M, Qtdos N(10,3), MetalNvs N(12,3))
            INDEX ON STR(Codigos, 6) + STR(Tubos, 2) TAG Tubos
            INDEX ON STR(Codigos, 6) + CodCors + STR(Tubos, 2) TAG Impressao

            *-- Query principal: SigCdFun x SigCdFud x SigCdCor
            loc_cSQL = "SELECT b.*, a.Obss AS ObsG, a.Datas, c.Pesos " + ;
                       "FROM SigCdFun a, SigCdFud b, SigCdCor c " + ;
                       "WHERE a.Codigos BETWEEN " + FormatarNumeroSQL(THIS.this_nFundI) + ;
                       " AND " + FormatarNumeroSQL(THIS.this_nFundF) + ;
                       " AND a.Codigos = b.Codigos" + ;
                       " AND b.Nops = 0 AND b.NNumes = 0 AND b.CodCors = c.Cods" + ;
                       " ORDER BY a.Codigos, b.Tubos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados")

            IF loc_nResult >= 1
                *-- Query secundaria: QtdOs agregado por OS (Nops > 0)
                loc_cSQL = "SELECT b.Codigos, b.Tubos, SUM(b.QtdOs) AS QtdOs " + ;
                           "FROM SigCdFun a, SigCdFud b " + ;
                           "WHERE a.Codigos BETWEEN " + FormatarNumeroSQL(THIS.this_nFundI) + ;
                           " AND " + FormatarNumeroSQL(THIS.this_nFundF) + ;
                           " AND a.Codigos = b.Codigos AND b.Nops > 0 " + ;
                           "GROUP BY b.Codigos, b.Tubos"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTubos")

                IF loc_nResult >= 1
                    *-- Cursor intermediario com transformacoes de tipo
                    SELECT crDados.Codigos, crDados.Tubos, crDados.NNumes, crDados.Nops, ;
                           crDados.Qtds, crDados.QtdOs, crDados.BCeras, crDados.Bases, ;
                           crDados.CodCors, crDados.Metals, crDados.MetalNvs, ;
                           NVL(crDados.Obss, SPACE(100)) AS Obss, ;
                           crDados.TempMets, crDados.TempAmbs, crDados.TempTubs, crDados.TempAgus, ;
                           NVL(crDados.ObsG, SPACE(100)) AS ObsG, ;
                           TTOD(NVL(crDados.Datas, CTOT(""))) AS Datas, ;
                           crDados.Pesos ;
                           FROM crDados ;
                           INTO CURSOR Selecao READWRITE

                    *-- Montar cursor Relatorio via SCAN (logica original preservada)
                    SELECT Selecao
                    GO TOP
                    SCAN
                        loc_nCod = Codigos

                        SELECT Relatorio
                        APPEND BLANK
                        REPLACE Codigos WITH loc_nCod, ;
                                Tubos   WITH 99, ;
                                CodCors WITH "ZZZZ", ;
                                ObsG    WITH Selecao.ObsG

                        SELECT Selecao
                        SCAN WHILE Codigos = loc_nCod
                            SCATTER MEMVAR MEMO
                            m.Ceras = m.bCeras - m.Bases

                            SELECT Relatorio
                            APPEND BLANK
                            GATHER MEMVAR MEMO
                        ENDSCAN
                        SKIP -1
                    ENDSCAN

                    *-- Preencher QtdOs das OS nos registros correspondentes
                    SELECT crTubos
                    SCAN
                        IF SEEK(STR(crTubos.Codigos, 6) + STR(crTubos.Tubos, 2), "Relatorio", "Tubos")
                            REPLACE Relatorio.QtdOs WITH crTubos.QtdOs IN Relatorio
                        ENDIF
                    ENDSCAN

                    SELECT Relatorio
                    GO TOP

                    IF USED("crDados")
                        USE IN crDados
                    ENDIF
                    IF USED("crTubos")
                        USE IN crTubos
                    ENDIF
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar totais de tubos"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar dados de fundi" + CHR(231) + CHR(227) + "o"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
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
                REPORT FORM (THIS.this_cNomeRelatorio) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cNomeRelatorio) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirSilencioso - Imprime relatorio sem dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirSilencioso()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cNomeRelatorio) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores do relatorio ao destruir o objeto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("Relatorio")
            USE IN Relatorio
        ENDIF
        IF USED("crDados")
            USE IN crDados
        ENDIF
        IF USED("crTubos")
            USE IN crTubos
        ENDIF
        IF USED("Selecao")
            USE IN Selecao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
