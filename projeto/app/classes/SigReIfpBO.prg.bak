*==============================================================================
* SIGREIFPBO.PRG
* Business Object para Relatorio de Falhas / Perdas
*
* Herda de RelatorioBase
* Form: FormSigReIfp
* Relatorios FRX: SigReIfA..SigReIfF (conforme NivImprs 1-7)
* Tabela principal de dados: SigCdFea
* Tabelas auxiliares: SigCdGcr, SigCdCli, SigOpOpt
*==============================================================================

DEFINE CLASS SigReIfpBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_nNivImprs      = 1
    this_cTpMat         = ""
    this_cIfor          = ""
    this_cDfor          = ""
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""

    *-- Cursor de dados produzido por PrepararDados (mantido como TmpRelat para compatibilidade com FRX)
    this_cCursorDados   = "TmpRelat"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO e carrega cursores auxiliares de setores e clientes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            IF DODEFAULT()
                loc_lSucesso = THIS.CarregarCursoresAuxiliares()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursoresAuxiliares - Carrega TmpGccr (setores) e TmpCli (clientes)
    * Chamado uma vez no Init; cursores persistem durante a vida do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCursoresAuxiliares()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF USED("TmpGccr")
                USE IN TmpGccr
            ENDIF
            IF USED("TmpCli")
                USE IN TmpCli
            ENDIF

            *-- Setores com BalFalPers = 1
            loc_cSQL = "SELECT * FROM SigCdGcr WHERE BalFalPers = 1"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "TmpGccr")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar setores (TmpGccr)"
                MsgErro("Erro ao carregar setores. Verifique a conex" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpGccr
            INDEX ON Codigos TAG Grupos

            *-- Clientes vinculados a setores com BalFalPers = 1
            loc_cSQL = "SELECT a.* FROM SigCdCli a, SigCdGcr b " + ;
                       "WHERE a.Grupos = b.Codigos AND b.BalFalPers = 1"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "TmpCli")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar clientes (TmpCli)"
                MsgErro("Erro ao carregar clientes. Verifique a conex" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpCli
            INDEX ON Iclis          TAG Iclis
            INDEX ON Grupos + Iclis TAG Grupos

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta TmpRelat e dbCabecalho para os FRX de relatorio
    * Replica a logica do PROCEDURE processamento do form legado SIGREIFP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        LOCAL loc_ldDti, loc_ldDtf, loc_lnNiv, loc_lcNiv
        LOCAL loc_lcTpM, loc_lcFor, loc_lcGrp
        LOCAL loc_nTotGccr, loc_nTotCli, loc_nTotClig
        LOCAL loc_lnTrab, loc_lnFalha, loc_lnPeso, loc_lnPerda, loc_lnTPerda
        LOCAL loc_lnRecupera, loc_lnPesob, loc_lnReccb, loc_lnRecsb
        LOCAL loc_cCab, loc_cSub, loc_cEmp, loc_cTit
        LOCAL loc_cDtI, loc_cDtF
        LOCAL loc_cGrSeek, loc_cIfors7

        loc_lSucesso = .F.
        TRY
            *-- Obter filtros do BO
            loc_ldDti  = THIS.this_dDtInicial
            loc_ldDtf  = THIS.this_dDtFinal
            loc_lnNiv  = THIS.this_nNivImprs
            loc_lcNiv  = STR(loc_lnNiv, 1)
            loc_lcTpM  = ALLTRIM(THIS.this_cTpMat)
            loc_lcFor  = ALLTRIM(THIS.this_cIfor)
            loc_lcGrp  = ALLTRIM(THIS.this_cCdGrupo)

            *-- Validar periodo
            IF EMPTY(loc_ldDti) OR EMPTY(loc_ldDtf)
                THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo inicial e final"
                MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar cursores auxiliares
            IF !USED("TmpGccr") OR !USED("TmpCli")
                IF !THIS.CarregarCursoresAuxiliares()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Fechar cursores de execucoes anteriores
            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            IF USED("csSelecao")
                USE IN csSelecao
            ENDIF
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            IF USED("crSigCdCli")
                USE IN crSigCdCli
            ENDIF
            IF USED("crSigCdEmp")
                USE IN crSigCdEmp
            ENDIF

            *-- Criar cursor de resultado (mesmo esquema que o original)
            CREATE CURSOR TmpRelat (Operacs c(30), Totas n(12,2), Grupos c(10), Dgrupos c(30), ;
                Contas c(10), Rclis c(30), ;
                falhags n(12,2), Recupgs n(12,2), Perdags n(12,2), Falhaps n(7,2), Recupps n(7,2), ;
                Perdaps n(7,2), Trabs n(12,2), fatrabs n(7,2), recfals n(7,2), Perdidos n(7,2), ;
                pertrabs n(7,2), TpOps c(15), Pesbs n(12,2), recCcobs n(12,2), RecScobs n(12,2), ;
                recpesos n(7,2), Nivels c(1), Datas d)
            INDEX ON Operacs                             TAG Operacao
            INDEX ON Nivels + Grupos                     TAG Grupos
            INDEX ON Contas                              TAG Contas
            INDEX ON Grupos + Contas                     TAG GruCon
            INDEX ON Grupos + TpOps                      TAG GruTp
            INDEX ON TpOps + Grupos + Contas + DTOS(Datas) TAG TpGruCond

            *-- Buscar registros de falhas/perdas no periodo (YYYYMMDD + tempo para DATETIME)
            loc_cDtI = DTOC(loc_ldDti, 1)
            loc_cDtF = DTOC(loc_ldDtf, 1)
            loc_cSQL = "SELECT * FROM SigCdFea " + ;
                       "WHERE Datas BETWEEN " + EscaparSQL(loc_cDtI) + " AND " + EscaparSQL(loc_cDtF + " 23:59:59") + ;
                       " AND (Tipos = 'F' OR (Tipos = 'P' AND Baixas = 1))"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "csSelecao")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de falhas/perdas"
                MsgErro("Erro ao buscar dados. Verifique a conex" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Contar totais dos cursores auxiliares
            SELECT TmpGccr
            COUNT TO loc_nTotGccr

            SELECT TmpCli
            COUNT TO loc_nTotCli

            *=========================================
            * NIVEL 1 - Resumo global (totais)
            *=========================================
            IF (loc_lnNiv = 1)
                SELECT TmpRelat
                SET ORDER TO
                SELECT csSelecao
                SUM Produzidos, Falhas, Pesoccbs TO loc_lnTrab, loc_lnFalha, loc_lnPeso
                loc_lnPerda = loc_lnFalha - loc_lnPeso
                SELECT TmpRelat
                APPEND BLANK
                REPLACE Operacs WITH "Produzido (g)", ;
                        Totas   WITH loc_lnTrab
                APPEND BLANK
                REPLACE Operacs WITH "Falha (g)", ;
                        Totas   WITH loc_lnFalha
                APPEND BLANK
                REPLACE Operacs WITH "Recupera" + CHR(231) + CHR(227) + "o c/Cobr (g)", ;
                        Totas   WITH loc_lnPeso
                APPEND BLANK
                REPLACE Operacs WITH "Perda (g)", ;
                        Totas   WITH loc_lnPerda
                APPEND BLANK
                REPLACE Operacs WITH "Falha/Produzido (%)", ;
                        Totas   WITH IIF(loc_lnTrab <> 0, (loc_lnFalha / loc_lnTrab * 100), 0)
                APPEND BLANK
                REPLACE Operacs WITH "Recupera" + CHR(231) + CHR(227) + "o/Falha (%)", ;
                        Totas   WITH IIF(loc_lnFalha <> 0, (loc_lnPeso / loc_lnFalha * 100), 0)
                APPEND BLANK
                REPLACE Operacs WITH "Perda/Produzido (%)", ;
                        Totas   WITH IIF(loc_lnTrab <> 0, (loc_lnPerda / loc_lnTrab * 100), 0)
            ENDIF

            *=========================================
            * NIVEL 2 - Por setor (Grupos)
            *=========================================
            IF (loc_lnNiv = 2)
                SELECT TmpRelat
                SET ORDER TO Grupos
                SELECT csSelecao
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF

                    IF EMPTY(csSelecao.Grupos)
                        loc_lnRecupera = IIF(loc_nTotGccr > 0, csSelecao.Pesoccbs / loc_nTotGccr, 0)
                        SELECT TmpGccr
                        SCAN
                            SELECT TmpRelat
                            SET ORDER TO Grupos
                            SEEK loc_lcNiv + TmpGccr.Codigos
                            IF EOF()
                                APPEND BLANK
                                REPLACE Grupos  WITH TmpGccr.Codigos, ;
                                        Dgrupos WITH TmpGccr.Descrs, ;
                                        Nivels  WITH loc_lcNiv
                            ENDIF
                            REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        ENDSCAN
                    ELSE
                        SELECT TmpGccr
                        SET ORDER TO Grupos
                        SEEK csSelecao.Grupos
                        loc_lnRecupera = csSelecao.Pesoccbs
                        SELECT TmpRelat
                        SEEK loc_lcNiv + csSelecao.Grupos
                        IF EOF()
                            APPEND BLANK
                            REPLACE Grupos  WITH csSelecao.Grupos, ;
                                    Dgrupos WITH TmpGccr.Descrs, ;
                                    Nivels  WITH loc_lcNiv
                        ENDIF
                        REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        REPLACE falhags WITH falhags + csSelecao.Falhas
                        REPLACE Trabs   WITH Trabs   + csSelecao.Trabs
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SUM falhags, Recupgs TO loc_lnFalha, loc_lnPeso
                loc_lnTPerda = loc_lnFalha - loc_lnPeso
                SCAN
                    REPLACE Perdags WITH falhags - Recupgs, ;
                            Falhaps WITH IIF(loc_lnFalha  <> 0, (falhags  / loc_lnFalha  * 100), 0), ;
                            Recupps WITH IIF(loc_lnPeso   <> 0, (Recupgs  / loc_lnPeso   * 100), 0), ;
                            Perdaps WITH IIF(loc_lnTPerda <> 0, (Perdags  / loc_lnTPerda * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 3 - Por cliente (falhas)
            *=========================================
            IF (loc_lnNiv = 3)
                SELECT TmpRelat
                SET ORDER TO Contas
                SELECT csSelecao
                SUM Falhas TO loc_lnFalha
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF
                    IF csSelecao.Tipos = "F"
                        =SEEK(csSelecao.Contas, "TmpCli", "Iclis")
                        SELECT TmpRelat
                        SEEK csSelecao.Contas
                        IF EOF()
                            APPEND BLANK
                            REPLACE Contas WITH csSelecao.Contas, ;
                                    Rclis  WITH TmpCli.Rclis, ;
                                    Nivels WITH loc_lcNiv
                        ENDIF
                        REPLACE falhags WITH falhags + csSelecao.Falhas
                    ENDIF
                ENDSCAN
                SELECT TmpRelat
                SCAN
                    REPLACE Falhaps WITH IIF(loc_lnFalha <> 0, (falhags / loc_lnFalha * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 4 - Por cliente (recuperacoes)
            *=========================================
            IF (loc_lnNiv = 4)
                SELECT TmpRelat
                SET ORDER TO Contas
                SELECT csSelecao
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF

                    IF EMPTY(csSelecao.Grupos)
                        loc_lnRecupera = IIF(loc_nTotCli > 0, csSelecao.Pesoccbs / loc_nTotCli, 0)
                        SELECT TmpCli
                        SCAN
                            SELECT TmpRelat
                            SET ORDER TO Contas
                            SEEK TmpCli.Iclis
                            IF EOF()
                                APPEND BLANK
                                REPLACE Contas WITH TmpCli.Iclis, ;
                                        Rclis  WITH TmpCli.Rclis, ;
                                        Nivels WITH loc_lcNiv
                            ENDIF
                            REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        ENDSCAN
                    ELSE
                        IF EMPTY(csSelecao.Contas)
                            loc_cGrSeek = csSelecao.Grupos
                            SELECT TmpCli
                            SET ORDER TO Grupos
                            SEEK loc_cGrSeek
                            COUNT TO loc_nTotClig WHILE Grupos = loc_cGrSeek
                            loc_lnRecupera = IIF(loc_nTotClig > 0, ;
                                csSelecao.Pesoccbs / loc_nTotClig, 0)
                            SEEK loc_cGrSeek
                            SCAN WHILE Grupos = loc_cGrSeek
                                SELECT TmpRelat
                                SEEK TmpCli.Iclis
                                IF EOF()
                                    APPEND BLANK
                                    REPLACE Contas WITH TmpCli.Iclis, ;
                                            Rclis  WITH TmpCli.Rclis, ;
                                            Nivels WITH loc_lcNiv
                                ENDIF
                                REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                            ENDSCAN
                        ELSE
                            loc_lnRecupera = csSelecao.Pesoccbs
                            =SEEK(csSelecao.Contas, "TmpCli", "Iclis")
                            SELECT TmpRelat
                            SEEK csSelecao.Contas
                            IF EOF()
                                APPEND BLANK
                                REPLACE Contas WITH TmpCli.Iclis, ;
                                        Rclis  WITH TmpCli.Rclis, ;
                                        Nivels WITH loc_lcNiv
                            ENDIF
                            REPLACE falhags WITH falhags + csSelecao.Falhas
                            REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SUM falhags - Recupgs TO loc_lnTPerda
                SCAN
                    REPLACE Perdags WITH falhags - Recupgs
                    REPLACE Perdaps WITH IIF(loc_lnTPerda <> 0, (Perdags / loc_lnTPerda * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 5 - Por setor e cliente
            *=========================================
            IF (loc_lnNiv = 5)
                SELECT TmpRelat
                SET ORDER TO GruCon
                SELECT csSelecao
                SCAN
                    IF EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                       !EMPTY(csSelecao.Produzidos)
                        LOOP
                    ENDIF

                    IF csSelecao.Tipos = "F"
                        SELECT TmpRelat
                        SEEK csSelecao.Grupos + csSelecao.Contas
                        IF EOF()
                            APPEND BLANK
                            REPLACE Grupos WITH csSelecao.Grupos, ;
                                    Contas WITH csSelecao.Contas
                        ENDIF
                        REPLACE Trabs   WITH Trabs   + csSelecao.Trabs
                        REPLACE falhags WITH falhags + csSelecao.Falhas
                    ELSE
                        IF EMPTY(csSelecao.Grupos)
                            loc_lnRecupera = IIF(loc_nTotCli > 0, csSelecao.Pesoccbs / loc_nTotCli, 0)
                            SELECT TmpCli
                            SCAN
                                SELECT TmpRelat
                                SEEK TmpCli.Grupos + TmpCli.Iclis
                                IF EOF()
                                    APPEND BLANK
                                    REPLACE Grupos WITH TmpCli.Grupos, ;
                                            Contas WITH TmpCli.Iclis
                                ENDIF
                                REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                            ENDSCAN
                        ELSE
                            IF EMPTY(csSelecao.Contas)
                                loc_cGrSeek = csSelecao.Grupos
                                SELECT TmpCli
                                SET ORDER TO Grupos
                                SEEK loc_cGrSeek
                                COUNT TO loc_nTotClig WHILE Grupos = loc_cGrSeek
                                loc_lnRecupera = IIF(loc_nTotClig > 0, ;
                                    csSelecao.Pesoccbs / loc_nTotClig, 0)
                                SEEK loc_cGrSeek
                                SCAN WHILE Grupos = loc_cGrSeek
                                    SELECT TmpRelat
                                    SEEK TmpCli.Grupos + TmpCli.Iclis
                                    IF EOF()
                                        APPEND BLANK
                                        REPLACE Contas WITH TmpCli.Iclis, ;
                                                Grupos WITH TmpCli.Grupos
                                    ENDIF
                                    REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                                ENDSCAN
                            ELSE
                                loc_lnRecupera = csSelecao.Pesoccbs
                                =SEEK(csSelecao.Contas, "TmpCli", "Iclis")
                                SELECT TmpRelat
                                SEEK csSelecao.Grupos + csSelecao.Contas
                                IF EOF()
                                    APPEND BLANK
                                    REPLACE Contas WITH TmpCli.Iclis, ;
                                            Grupos WITH TmpCli.Grupos
                                ENDIF
                                REPLACE falhags WITH falhags + csSelecao.Falhas
                                REPLACE Recupgs WITH Recupgs + loc_lnRecupera
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SCAN
                    REPLACE Perdags  WITH falhags - Recupgs, ;
                            fatrabs  WITH IIF(Trabs   <> 0, (falhags  / Trabs   * 100), 0), ;
                            recfals  WITH IIF(falhags <> 0, (Recupgs  / falhags * 100), 0), ;
                            Pertrabs WITH IIF(Trabs   <> 0, (Perdags  / Trabs   * 100), 0), ;
                            Perdidos WITH IIF(falhags <> 0, (Perdags  / falhags * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 6 - Por setor e tipo de material
            *=========================================
            IF (loc_lnNiv = 6)
                SELECT TmpRelat
                SET ORDER TO GruTp
                SELECT csSelecao
                SCAN
                    IF (csSelecao.Tipos = "F") OR ;
                       (EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                        !EMPTY(csSelecao.Produzidos))
                        LOOP
                    ENDIF

                    IF EMPTY(csSelecao.Grupos)
                        loc_lnPesob = IIF(loc_nTotGccr > 0, csSelecao.Brutos   / loc_nTotGccr, 0)
                        loc_lnReccb = IIF(loc_nTotGccr > 0, csSelecao.Pesoccbs / loc_nTotGccr, 0)
                        loc_lnRecsb = IIF(loc_nTotGccr > 0, csSelecao.Pesoscbs / loc_nTotGccr, 0)
                        SELECT TmpGccr
                        SCAN
                            SELECT TmpRelat
                            SET ORDER TO GruTp
                            SEEK TmpGccr.Codigos + csSelecao.TpMats
                            IF EOF()
                                APPEND BLANK
                                REPLACE Grupos WITH TmpGccr.Codigos, ;
                                        TpOps  WITH csSelecao.TpMats
                            ENDIF
                            REPLACE Pesbs    WITH Pesbs    + loc_lnPesob, ;
                                    recCcobs WITH recCcobs + loc_lnReccb, ;
                                    RecScobs WITH RecScobs + loc_lnRecsb
                        ENDSCAN
                    ELSE
                        loc_lnPesob = csSelecao.Brutos
                        loc_lnReccb = csSelecao.Pesoccbs
                        loc_lnRecsb = csSelecao.Pesoscbs
                        SELECT TmpRelat
                        SET ORDER TO GruTp
                        SEEK csSelecao.Grupos + csSelecao.TpMats
                        IF EOF()
                            APPEND BLANK
                            REPLACE Grupos WITH csSelecao.Grupos, ;
                                    TpOps  WITH csSelecao.TpMats
                        ENDIF
                        REPLACE Pesbs    WITH Pesbs    + loc_lnPesob, ;
                                recCcobs WITH recCcobs + loc_lnReccb, ;
                                RecScobs WITH RecScobs + loc_lnRecsb
                    ENDIF
                ENDSCAN

                SELECT TmpRelat
                SCAN
                    REPLACE recpesos WITH IIF(Pesbs <> 0, (RecScobs / Pesbs * 100), 0)
                ENDSCAN
            ENDIF

            *=========================================
            * NIVEL 7 - Detalhado (tipo+setor+cliente+data)
            *=========================================
            IF (loc_lnNiv = 7)
                SELECT TmpRelat
                SET ORDER TO TpGruCond
                SELECT csSelecao
                SCAN
                    IF csSelecao.Tipos = "F" OR ;
                       (EMPTY(csSelecao.Grupos) AND EMPTY(csSelecao.Contas) AND ;
                        !EMPTY(csSelecao.Produzidos))
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_lcTpM) AND loc_lcTpM <> ALLTRIM(csSelecao.TpMats)
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_lcFor) AND loc_lcFor <> ALLTRIM(csSelecao.Ifors)
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_lcGrp) AND loc_lcGrp <> ALLTRIM(csSelecao.Grupos)
                        LOOP
                    ENDIF

                    *-- Buscar descricao da recuperadora via TmpCli (cursor em memoria)
                    loc_cIfors7 = ALLTRIM(csSelecao.Ifors)
                    LOCAL loc_cRclis7
                    loc_cRclis7 = ""
                    IF USED("TmpCli")
                        =SEEK(loc_cIfors7, "TmpCli", "Iclis")
                        IF !EOF("TmpCli") AND ALLTRIM(TmpCli.Iclis) = loc_cIfors7
                            loc_cRclis7 = ALLTRIM(TmpCli.Rclis)
                        ENDIF
                    ENDIF

                    loc_lnPesob = csSelecao.Brutos
                    loc_lnRecsb = csSelecao.Pesoscbs
                    SELECT TmpRelat
                    APPEND BLANK
                    REPLACE Contas   WITH csSelecao.Grupos, ;
                            TpOps    WITH csSelecao.TpMats, ;
                            Datas    WITH csSelecao.Datas, ;
                            Grupos   WITH csSelecao.Ifors, ;
                            Dgrupos  WITH loc_cRclis7, ;
                            Pesbs    WITH Pesbs    + csSelecao.Brutos, ;
                            RecScobs WITH RecScobs + csSelecao.Pesoscbs, ;
                            recpesos WITH IIF(Pesbs <> 0, (RecScobs / Pesbs * 100), 0)
                ENDSCAN
            ENDIF

            *-- Montar cabecalho para os FRX
            loc_cCab = "Rela" + CHR(231) + CHR(227) + "o de Falhas / Perdas"
            loc_cSub = "Per" + CHR(237) + "odo: " + DTOC(loc_ldDti) + " a " + DTOC(loc_ldDtf)

            *-- Razao social da empresa via go_4c_Sistema
            loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            *-- Linha de filtros ativos
            loc_cTit = IIF(!EMPTY(loc_lcTpM), loc_lcTpM, "") + ;
                       IIF(!EMPTY(loc_lcFor), " / " + loc_lcFor, "") + ;
                       IIF(!EMPTY(loc_lcGrp), " / " + loc_lcGrp, "")
            loc_cTit = IIF(!EMPTY(loc_cTit), "Filtros: " + loc_cTit, "")

            *-- Cursor de cabecalho usado pelos FRX
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (Titulo c(100), SubTitulo c(100), NomeEmpresa c(100), Periodos c(100))
            INSERT INTO dbCabecalho (Titulo, Periodos, NomeEmpresa, SubTitulo) ;
                VALUES (loc_cCab, loc_cTit, loc_cEmp, loc_cSub)

            *-- Posicionar TmpRelat no inicio para o FRX
            SELECT TmpRelat
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            loc_cFrx = THIS.ObterRelatorioFrx()
            IF EMPTY(loc_cFrx)
                THIS.this_cMensagemErro = "N" + CHR(237) + "vel de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido"
                MsgAviso("N" + CHR(237) + "vel de relat" + CHR(243) + "rio inv" + CHR(225) + ;
                         "lido (0 ou > 7).", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe o relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            loc_cFrx = THIS.ObterRelatorioFrx()
            IF EMPTY(loc_cFrx)
                THIS.this_cMensagemErro = "N" + CHR(237) + "vel de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido"
                MsgAviso("N" + CHR(237) + "vel de relat" + CHR(243) + "rio inv" + CHR(225) + ;
                         "lido (0 ou > 7).", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterRelatorioFrx - Retorna caminho do FRX conforme NivImprs
    *--------------------------------------------------------------------------
    FUNCTION ObterRelatorioFrx()
        LOCAL loc_cFrx
        loc_cFrx = ""
        DO CASE
            CASE THIS.this_nNivImprs = 1
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfA.frx"
            CASE THIS.this_nNivImprs = 2
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfB.frx"
            CASE THIS.this_nNivImprs = 3 OR THIS.this_nNivImprs = 4
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfC.frx"
            CASE THIS.this_nNivImprs = 5
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfD.frx"
            CASE THIS.this_nNivImprs = 6
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfE.frx"
            CASE THIS.this_nNivImprs = 7
                loc_cFrx = gc_4c_CaminhoReports + "SigReIfF.frx"
        ENDCASE
        RETURN loc_cFrx
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores do ciclo de vida do BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("TmpGccr")
            USE IN TmpGccr
        ENDIF
        IF USED("TmpCli")
            USE IN TmpCli
        ENDIF
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("csSelecao")
            USE IN csSelecao
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crSigCdCli")
            USE IN crSigCdCli
        ENDIF
        IF USED("crSigCdEmp")
            USE IN crSigCdEmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
