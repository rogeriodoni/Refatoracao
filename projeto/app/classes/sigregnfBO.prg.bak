*==============================================================================
* SIGREGNFBO.PRG
* Business Object - Emissao Global de Nota Fiscal
*
* Herda de RelatorioBase
* Selecao, verificacao, impressao e visualizacao de NFs
* Form legado: sigregnf.SCX (classe frmrelatorio)
*==============================================================================

DEFINE CLASS sigregnfBO AS RelatorioBase

    *-- Filtros de selecao (preenchidos pelo form antes de SelecionarDados)
    this_cSeries            = ""    && Serie da NF para filtro (C, 3)
    this_cUsuars            = ""    && Usuario para filtro (C, 10 - vazio = todos)

    *-- Estado interno do processamento
    this_lNotasAnt          = .F.   && .T. se existem notas anteriores nao impressas desta serie

    *-- Dados auxiliares carregados no Init
    this_cMascNums          = ""    && Mascara de numeracao de SigCdPam.MascNums

    *-- Nomes dos cursors de trabalho persistentes
    this_cCursorNFis        = "cursor_4c_TmpNFis"     && Dados das NFs selecionadas (usado no grid)
    this_cCursorClientes    = "cursor_4c_Clientes"    && Cache de clientes (Iclis/RClis)
    this_cCursorSeries      = "cursor_4c_SigCdSer"    && Series carregadas no Init (persiste para busca)

    *-- Mensagem de erro para o form exibir
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Cria cursors de trabalho e carrega dados auxiliares do banco
    * Equivalente ao Load + Init do legado: fConfigGeral + SigCdPam + SigCdSer
    * Em modo gb_4c_ValidandoUI (.T.) os cursores sao criados vazios sem SQL.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Cursor principal: equivalente ao TmpNFis do legado
            IF USED(THIS.this_cCursorNFis)
                USE IN (THIS.this_cCursorNFis)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorNFis) ;
                (Flag l, ;
                 Emis d, ;
                 Series c(3), ;
                 Operas c(1), ;
                 CFis c(10), ;
                 NFis c(6), ;
                 TotNotas n(12,2), ;
                 Conta c(40), ;
                 Operacao c(30), ;
                 Emps c(3), ;
                 Dopes c(20), ;
                 Numes n(6))
            INDEX ON NFis TAG NFis

            *-- Cursor auxiliar de clientes: equivalente ao crClientes do legado
            IF USED(THIS.this_cCursorClientes)
                USE IN (THIS.this_cCursorClientes)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorClientes) ;
                (Iclis c(10), RClis c(50))
            INDEX ON Iclis TAG Iclis

            *-- Em modo ValidarUI sem conexao SQL, cursores vazios sao suficientes
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = DODEFAULT()
            ELSE
                *-- Carregar mascara de numeracao de SigCdPam
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT MascNums FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nResult > 0 AND USED("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    IF !EOF()
                        THIS.this_cMascNums = ALLTRIM(NVL(MascNums, ""))
                    ENDIF
                    USE IN cursor_4c_SigCdPam
                ENDIF

                *-- Carregar series para validacao em SelecionarDados (mantido aberto)
                IF USED(THIS.this_cCursorSeries)
                    USE IN (THIS.this_cCursorSeries)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT EmpCods, TipoNfs FROM SigCdSer", ;
                    THIS.this_cCursorSeries)
                IF loc_nResult > 0 AND USED(THIS.this_cCursorSeries)
                    SELECT (THIS.this_cCursorSeries)
                    INDEX ON EmpCods TAG EmpCods
                    loc_lSucesso = DODEFAULT()
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdSer"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro do BO
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Hook de RelatorioBase: prepara dados para a tela/relatorio
    * Delega para SelecionarDados que monta filtros (Serie + Usuario opcional)
    * e popula cursor_4c_TmpNFis com as NFs disponiveis para impressao
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cSeries))
                THIS.this_cMensagemErro = "S" + CHR(233) + "rie n" + CHR(227) + ;
                                          "o informada"
            ELSE
                loc_lSucesso = THIS.SelecionarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente em cursor_4c_TmpNFis
    * Formato: Emps + Dopes + Numes (mesmo padrao EmpDopNums do legado)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED(THIS.this_cCursorNFis)
            SELECT (THIS.this_cCursorNFis)
            IF !EOF() AND !BOF()
                loc_cChave = EVALUATE(THIS.this_cCursorNFis + ".Emps") + ;
                             ALLTRIM(EVALUATE(THIS.this_cCursorNFis + ".Dopes")) + ;
                             STR(EVALUATE(THIS.this_cCursorNFis + ".Numes"), 6)
            ENDIF
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de emissao/visualizacao de NFs
    * Insere em LogAuditoria via INSERT direto (sem BusinessBase neste fluxo)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF !EMPTY(loc_cChave)
                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                           "(Tabela, ChaveRegistro, Operacao, Usuario, DataHora) VALUES (" + ;
                           EscaparSQL("SigMvNfi") + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           "GETDATE())"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lSucesso = (loc_nResult >= 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Seleciona NFs disponiveis para impressao
    * Filtra por Serie (obrigatorio) e Usuario (opcional)
    * Popula cursor_4c_TmpNFis com NFs nao impressas/canceladas
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_lAbortado
        LOCAL loc_cEmpr, loc_cSeries, loc_cUsuars
        LOCAL loc_lcCli, loc_cDopes, loc_cEmps, loc_cMvSeries, loc_nNumes
        LOCAL loc_dEmis, loc_cOperas, loc_cCFis, loc_cNFis, loc_nTotNotas, loc_cCliFors
        loc_lSucesso = .F.
        TRY
            ZAP IN (THIS.this_cCursorNFis)
            WAIT WINDOW "Aguarde!!! Selecionando Notas Fiscais..." NOWAIT

            loc_cEmpr   = go_4c_Sistema.cCodEmpresa
            loc_cSeries = PADR(THIS.this_cSeries, 3)
            loc_cUsuars = PADR(THIS.this_cUsuars, 10)
            loc_lAbortado = .F.

            *-- Seleciona NFs nao impressas/canceladas da serie indicada
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                *-- Sem filtro de usuario: query direta em SigMvNfi
                loc_cSQL = "SELECT a.Emis, a.Series, a.Operas, a.CFis, a.NFis, " + ;
                           "a.TotNotas, a.CliFors, a.Emps, a.Dopes, a.Numes, b.Rclis " + ;
                           "FROM SigMvNfi a " + ;
                           "LEFT JOIN SigCdCli b ON b.Iclis = a.CliFors " + ;
                           "WHERE a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                           " AND a.Series = " + EscaparSQL(loc_cSeries) + ;
                           " AND a.Cancelas = 0 AND a.Impress = 0 " + ;
                           "ORDER BY a.NFis"
            ELSE
                *-- Com filtro de usuario: join via SigMvCab para filtrar por Usuars
                loc_cSQL = "SELECT a.Emis, a.Series, a.Operas, a.CFis, a.NFis, " + ;
                           "a.TotNotas, a.CliFors, a.Emps, a.Dopes, a.Numes, c.Rclis " + ;
                           "FROM SigMvNfi a " + ;
                           "INNER JOIN SigMvCab cab ON cab.EmpDopNums = a.EmpDopNums " + ;
                           "LEFT JOIN SigCdCli c ON c.Iclis = a.CliFors " + ;
                           "WHERE a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                           " AND a.Series = " + EscaparSQL(loc_cSeries) + ;
                           " AND cab.Usuars = " + EscaparSQL(loc_cUsuars) + ;
                           " AND a.Cancelas = 0 AND a.Impress = 0 " + ;
                           "ORDER BY a.NFis"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao selecionar NFs"
                loc_lAbortado = .T.
            ENDIF

            IF !loc_lAbortado
                *-- Carrega operacoes para filtragem por tipo
                IF USED("cursor_4c_SigCdOpe")
                    USE IN cursor_4c_SigCdOpe
                ENDIF
                loc_nResult2 = SQLEXEC(gnConnHandle, ;
                    "SELECT Dopes, TipoNfs, Nfiscals, Agrupas FROM SigCdOpe", ;
                    "cursor_4c_SigCdOpe")
                IF loc_nResult2 < 1 OR !USED("cursor_4c_SigCdOpe")
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdOpe)"
                    loc_lAbortado = .T.
                ELSE
                    SELECT cursor_4c_SigCdOpe
                    INDEX ON Dopes TAG Dopes ADDITIVE
                ENDIF
            ENDIF

            IF !loc_lAbortado
                *-- Scan: aplica filtros de tipo e insere em cursor_4c_TmpNFis
                SELECT cursor_4c_SigMvNfi
                SCAN
                    *-- Captura campos antes de mudar work area
                    loc_lcCli     = ALLTRIM(NVL(cursor_4c_SigMvNfi.Rclis, ""))
                    loc_cDopes    = cursor_4c_SigMvNfi.Dopes
                    loc_cEmps     = cursor_4c_SigMvNfi.Emps
                    loc_cMvSeries = cursor_4c_SigMvNfi.Series
                    loc_nNumes    = cursor_4c_SigMvNfi.Numes
                    loc_dEmis     = cursor_4c_SigMvNfi.Emis
                    loc_cOperas   = cursor_4c_SigMvNfi.Operas
                    loc_cCFis     = cursor_4c_SigMvNfi.CFis
                    loc_cNFis     = cursor_4c_SigMvNfi.NFis
                    loc_nTotNotas = cursor_4c_SigMvNfi.TotNotas
                    loc_cCliFors  = cursor_4c_SigMvNfi.CliFors

                    =SEEK(loc_cDopes, "cursor_4c_SigCdOpe", "Dopes")

                    IF !SEEK(loc_cEmpr + loc_cMvSeries, THIS.this_cCursorSeries, "EmpCods")
                        =SEEK(SPACE(3) + loc_cMvSeries, THIS.this_cCursorSeries, "EmpCods")
                    ENDIF

                    *-- Filtra por tipo de NF (igual ao legado)
                    IF !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.TipoNfs = 4
                        IF EOF(THIS.this_cCursorSeries) OR ;
                           EVALUATE(THIS.this_cCursorSeries + ".TipoNfs") = 2
                            LOOP
                        ENDIF
                    ELSE
                        IF !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.TipoNfs = 2
                            LOOP
                        ENDIF
                        IF EOF(THIS.this_cCursorSeries) OR ;
                           EVALUATE(THIS.this_cCursorSeries + ".TipoNfs") = 2
                            LOOP
                        ENDIF
                    ENDIF

                    INSERT INTO (THIS.this_cCursorNFis) ;
                        (Flag, Emis, Series, Operas, CFis, NFis, TotNotas, Conta, ;
                         Operacao, Emps, Dopes, Numes) ;
                        VALUES (.T., ;
                                NVL(loc_dEmis, CTOD("")), ;
                                loc_cMvSeries, ;
                                loc_cOperas, ;
                                loc_cCFis, ;
                                loc_cNFis, ;
                                loc_nTotNotas, ;
                                loc_cCliFors + " " + loc_lcCli, ;
                                loc_cEmps + ALLTRIM(loc_cDopes) + ;
                                    " " + ALLTRIM(fGerMascara(loc_nNumes)), ;
                                loc_cEmps, ;
                                loc_cDopes, ;
                                loc_nNumes)
                ENDSCAN

                IF USED("cursor_4c_SigCdOpe")
                    USE IN cursor_4c_SigCdOpe
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            WAIT CLEAR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarNf - Verifica se existem NFs anteriores nao impressas da serie
    * Retorna .T. se pode prosseguir, .F. se ha bloqueio por nota anterior
    *--------------------------------------------------------------------------
    PROCEDURE VerificarNf()
        LOCAL loc_lSucesso, loc_nResult, loc_lAbortado
        LOCAL loc_lcEdn, loc_lcSql, loc_lcNota, loc_lcTxt
        LOCAL loc_cVEmps, loc_cVDopes, loc_cVSeries, loc_nVNumes, loc_cVNFis
        loc_lSucesso = .T.
        TRY
            loc_lAbortado = .F.
            SELECT (THIS.this_cCursorNFis)
            SCAN WHILE !loc_lAbortado
                IF !Flag
                    LOOP
                ENDIF
                loc_cVEmps   = Emps
                loc_cVDopes  = Dopes
                loc_cVSeries = Series
                loc_nVNumes  = Numes
                loc_cVNFis   = NFis

                loc_lcEdn = loc_cVEmps + loc_cVDopes + STR(loc_nVNumes, 6)

                loc_lcSql = "SELECT DISTINCT c.Nfis, c.EmpDopNums " + ;
                            "FROM SigMvNfi c, SigCdOpe a " + ;
                            "WHERE c.emps = " + EscaparSQL(loc_cVEmps) + ;
                            " AND c.series = " + EscaparSQL(loc_cVSeries) + ;
                            " AND c.Impress = 0 AND c.cancelas = 0" + ;
                            " AND c.dopes = a.dopes AND a.nfiscals IN (1,2)" + ;
                            " AND a.tiponfs <> 4 AND a.agrupas = 1" + ;
                            " UNION ALL " + ;
                            "SELECT DISTINCT c.Nfis, c.EmpDopNums " + ;
                            "FROM SigMvNfi c, SigCdOpe a, SigCdSer b " + ;
                            "WHERE c.emps = " + EscaparSQL(loc_cVEmps) + ;
                            " AND c.series = " + EscaparSQL(loc_cVSeries) + ;
                            " AND c.Impress = 0 AND c.cancelas = 0" + ;
                            " AND c.series = b.cods AND c.dopes = a.dopes" + ;
                            " AND a.nfiscals IN (1,2) AND a.tiponfs = 4 AND b.impnfs = 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_TmpFiscal")
                IF loc_nResult < 0
                    MsgErro("Favor reinicializar o processo.", ;
                            "Falha na Conex" + CHR(227) + "o (TmpFiscal)")
                    loc_lSucesso  = .F.
                    loc_lAbortado = .T.
                ELSE
                    SELECT cursor_4c_TmpFiscal
                    IF RECCOUNT() > 0
                        LOCATE FOR EmpDopNums = loc_lcEdn
                        loc_lcNota = loc_cVNFis

                        SELECT * FROM cursor_4c_TmpFiscal ;
                            WHERE Nfis < loc_lcNota ;
                            INTO CURSOR cursor_4c_Selecao

                        SELECT cursor_4c_Selecao
                        IF RECCOUNT() > 0
                            loc_lcTxt = ""
                            SCAN
                                loc_lcTxt = loc_lcTxt + CHR(13) + ;
                                    "Nota : " + cursor_4c_Selecao.NFis + ;
                                    " - Opera" + CHR(231) + CHR(227) + "o : " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 01, 03)) + ;
                                    " / " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 04, 20)) + ;
                                    " / " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 24, 06)) + ;
                                    SPACE(10)
                            ENDSCAN
                            MsgAviso("Existem Notas Anteriores Desta S" + CHR(233) + ;
                                     "rie Ainda N" + CHR(227) + ;
                                     "o Impressas!!!" + loc_lcTxt, ;
                                     "Aten" + CHR(231) + CHR(227) + "o!!!")
                            loc_lSucesso = .F.
                        ENDIF
                        IF USED("cursor_4c_Selecao")
                            USE IN cursor_4c_Selecao
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_TmpFiscal")
                        USE IN cursor_4c_TmpFiscal
                    ENDIF
                ENDIF
            ENDSCAN

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - Verifica sequencia de NFs antes de imprimir
    * Consulta SigCnFn2 e chama VerificarNf para detectar notas anteriores
    * Deve ser chamado pelo form antes de Impressao()
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cSeries, loc_cEmps
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorNFis) OR EOF(THIS.this_cCursorNFis)
            RETURN .F.
        ENDIF

        TRY
            THIS.this_lNotasAnt = .F.

            loc_cSeries = EVALUATE(THIS.this_cCursorNFis + ".Series")
            loc_cEmps   = EVALUATE(THIS.this_cCursorNFis + ".Emps")

            loc_cSQL = "SELECT Series, Emps, VSeqNota FROM SigCnFn2 " + ;
                       "WHERE Series = " + EscaparSQL(loc_cSeries) + ;
                       " AND Emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND VSeqNota = 1"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCnFnfT")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigCnFnfT)")
            ELSE
                SELECT cursor_4c_SigCnFnfT
                IF !EOF()
                    IF !THIS.VerificarNf()
                        THIS.this_lNotasAnt = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_SigCnFnfT")
                    USE IN cursor_4c_SigCnFnfT
                ENDIF

                SELECT (THIS.this_cCursorNFis)
                GO TOP

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Impressao - Imprime todas as NFs marcadas (Flag=.T.)
    * Chama SigPrNfs para cada NF marcada e recarrega lista ao final
    *--------------------------------------------------------------------------
    PROCEDURE Impressao()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_cEdn, loc_lAbortado
        LOCAL loc_lFlag, loc_cEmps, loc_cDopes, loc_nNumes, loc_cNFis
        loc_lSucesso = .F.

        IF THIS.this_lNotasAnt
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_TprMvCab")
                USE IN cursor_4c_TprMvCab
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))
            SET NULL OFF

            GO BOTTOM IN (THIS.this_cCursorNFis)
            GO TOP IN (THIS.this_cCursorNFis)

            loc_lAbortado = .F.
            SELECT (THIS.this_cCursorNFis)
            SCAN WHILE !loc_lAbortado
                loc_lFlag  = Flag
                loc_cEmps  = Emps
                loc_cDopes = Dopes
                loc_nNumes = Numes
                loc_cNFis  = NFis

                IF loc_lFlag
                    WAIT WINDOW "Imprimindo Nota Fiscal n" + CHR(186) + " " + ;
                        loc_cNFis NOWAIT

                    ZAP IN cursor_4c_TprMvCab

                    loc_cEdn = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)

                    *-- Busca cabecalho em SigMvCab
                    loc_cSQL = "SELECT Emps, Dopes, Numes, ContaOs, ContaDs, " + ;
                               "TpFats, Obses, ValVars FROM SigMvCab " + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCab")
                    IF loc_nResult < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (SigMvCab)")
                        loc_lAbortado = .T.
                    ENDIF

                    IF !loc_lAbortado
                        GO TOP IN cursor_4c_SigMvCab

                        INSERT INTO cursor_4c_TprMvCab ;
                            (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
                            VALUES (cursor_4c_SigMvCab.Emps, cursor_4c_SigMvCab.Dopes, ;
                                    cursor_4c_SigMvCab.Numes, cursor_4c_SigMvCab.ContaOs, ;
                                    cursor_4c_SigMvCab.ContaDs, cursor_4c_SigMvCab.TpFats, ;
                                    cursor_4c_SigMvCab.Obses, cursor_4c_SigMvCab.ValVars)

                        *-- Busca itens em SigMvNfi
                        loc_cSQL = "SELECT * FROM SigMvNfi " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                        loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
                        IF loc_nResult2 < 1
                            MsgErro("Favor Reinicializar o Processo!!!", ;
                                    "Falha na Conex" + CHR(227) + "o (SigMvNfi)")
                            loc_lAbortado = .T.
                        ENDIF
                    ENDIF

                    IF !loc_lAbortado
                        GO TOP IN cursor_4c_SigMvNfi

                        *-- Imprime usando rotina legada SigPrNfs.prg
                        DO SigPrNfs WITH "I", loc_cEmps, loc_cDopes, loc_nNumes

                        SELECT (THIS.this_cCursorNFis)
                        DELETE
                    ENDIF
                ENDIF
            ENDSCAN

            IF !loc_lAbortado
                IF USED("cursor_4c_SigMvCab")
                    USE IN cursor_4c_SigMvCab
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF
                THIS.SelecionarDados()
                WAIT CLEAR
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizacao - Visualiza a NF do registro corrente do cursor
    * Cursor cursor_4c_TmpNFis deve estar posicionado no registro desejado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizacao()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_cEdn, loc_lAbortado
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes
        loc_lSucesso = .F.

        IF THIS.this_lNotasAnt
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorNFis)
        IF EOF() OR BOF() OR !Flag
            RETURN .F.
        ENDIF

        TRY
            loc_cEmps  = EVALUATE(THIS.this_cCursorNFis + ".Emps")
            loc_cDopes = EVALUATE(THIS.this_cCursorNFis + ".Dopes")
            loc_nNumes = EVALUATE(THIS.this_cCursorNFis + ".Numes")

            IF USED("cursor_4c_TprMvCab")
                USE IN cursor_4c_TprMvCab
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))
            SET NULL OFF

            loc_cEdn = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)
            loc_lAbortado = .F.

            *-- Busca cabecalho em SigMvCab
            loc_cSQL = "SELECT Emps, Dopes, Numes, ContaOs, ContaDs, " + ;
                       "TpFats, Obses, ValVars FROM SigMvCab " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCab")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigMvCab)")
                loc_lAbortado = .T.
            ENDIF

            IF !loc_lAbortado
                GO TOP IN cursor_4c_SigMvCab

                INSERT INTO cursor_4c_TprMvCab ;
                    (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
                    VALUES (cursor_4c_SigMvCab.Emps, cursor_4c_SigMvCab.Dopes, ;
                            cursor_4c_SigMvCab.Numes, cursor_4c_SigMvCab.ContaOs, ;
                            cursor_4c_SigMvCab.ContaDs, cursor_4c_SigMvCab.TpFats, ;
                            cursor_4c_SigMvCab.Obses, cursor_4c_SigMvCab.ValVars)

                *-- Busca itens em SigMvNfi
                loc_cSQL = "SELECT * FROM SigMvNfi " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
                IF loc_nResult2 < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigMvNfi)")
                    loc_lAbortado = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortado
                GO TOP IN cursor_4c_SigMvNfi

                *-- Visualiza usando rotina legada SigPrNfs.prg
                DO SigPrNfs WITH "V", loc_cEmps, loc_cDopes, loc_nNumes

                IF USED("cursor_4c_SigMvCab")
                    USE IN cursor_4c_SigMvCab
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF

                SELECT (THIS.this_cCursorNFis)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os registros do cursor TmpNFis (Flag=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        IF USED(THIS.this_cCursorNFis)
            UPDATE (THIS.this_cCursorNFis) SET Flag = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os registros do cursor TmpNFis (Flag=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF USED(THIS.this_cCursorNFis)
            UPDATE (THIS.this_cCursorNFis) SET Flag = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursors abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(10), loc_nI

        loc_aCursors(1)  = THIS.this_cCursorNFis
        loc_aCursors(2)  = THIS.this_cCursorClientes
        loc_aCursors(3)  = THIS.this_cCursorSeries
        loc_aCursors(4)  = "cursor_4c_TmpFiscal"
        loc_aCursors(5)  = "cursor_4c_SigCdOpe"
        loc_aCursors(6)  = "cursor_4c_SigMvNfi"
        loc_aCursors(7)  = "cursor_4c_SigMvCab"
        loc_aCursors(8)  = "cursor_4c_SigCnFnfT"
        loc_aCursors(9)  = "cursor_4c_TprMvCab"
        loc_aCursors(10) = "cursor_4c_Selecao"

        FOR loc_nI = 1 TO 10
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE
