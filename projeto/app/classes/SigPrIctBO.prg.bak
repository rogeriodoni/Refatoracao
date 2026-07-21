*==============================================================================
* SigPrIctBO.prg - Business Object para Integracao Contabil (SIGPRICT)
* Herda de BusinessBase
* Tabela principal: nenhuma (processamento sobre cursores temporarios)
*
* Funcionalidade:
*   - Processa movimentacao de conta corrente (SigMvCcr) no periodo
*   - Gera cursor MovAux com lancamentos contabeis
*   - Detecta inconsistencias: contas sem mapeamento, titulos sem centro de custo
*   - Gera arquivo contabil por empresa (CTPV*.EMP) em DirContabv
*
* Cursores criados:
*   MovAux     - Lancamentos contabeis gerados
*   SemConta   - Inconsistencias detectadas (para relatorio)
*   Cabecalho  - Cabecalho do relatorio
*   Grupos     - Grupos contabilizaveis (SigCdGcr filtrado)
*   LoteProc   - Lotes de cheques ja processados
*==============================================================================

DEFINE CLASS SigPrIctBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade (sem tabela persistente - processamento)
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * Parametros de execucao (entradas do usuario)
    *--------------------------------------------------------------------------
    this_dDataI = {}
    this_dDataF = {}

    *--------------------------------------------------------------------------
    * Parametros do sistema (SigCdPam)
    *--------------------------------------------------------------------------
    this_cDirContabv = ""
    this_cGrupoPags  = ""
    this_cGrupoRecs  = ""
    this_cMoedaCheqs = ""

    *--------------------------------------------------------------------------
    * Configuracao de historico (SigCdPac)
    *--------------------------------------------------------------------------
    this_nCfgHisICs = 0

    *--------------------------------------------------------------------------
    * Estado do processamento
    *--------------------------------------------------------------------------
    this_lParametrosCarregados = .F.
    this_lTemInconsistencias   = .F.
    this_lTemMovimento         = .F.
    this_lTemDiferencas        = .F.
    this_cMensagemErro         = ""

    *==========================================================================
    * Init - Inicializa o BO
    *==========================================================================
    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Sem tabela persistente
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega configuracoes do sistema (SigCdPam, SigCdPac)
    * Retorna .T. se sucesso
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cQuery, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cQuery = "SELECT DirContabv, GrupoPags, GrupoRecs, MoedaCheqs FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_Pam") < 1
                ERROR "Falha ao carregar par" + CHR(226) + "metros de pagamento (SigCdPam)"
            ENDIF
            IF USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                SELECT cursor_4c_Pam
                THIS.this_cDirContabv = ALLTRIM(TratarNulo(DirContabv, "C"))
                THIS.this_cGrupoPags  = ALLTRIM(TratarNulo(GrupoPags,  "C"))
                THIS.this_cGrupoRecs  = ALLTRIM(TratarNulo(GrupoRecs,  "C"))
                THIS.this_cMoedaCheqs = ALLTRIM(TratarNulo(MoedaCheqs, "C"))
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            loc_cQuery = "SELECT CfgHisICs FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_Pac") < 1
                ERROR "Falha ao carregar par" + CHR(226) + "metros cont" + CHR(225) + "beis (SigCdPac)"
            ENDIF
            IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                SELECT cursor_4c_Pac
                THIS.this_nCfgHisICs = TratarNulo(CfgHisICs, "N")
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF

            THIS.this_lParametrosCarregados = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarCursores - Cria ou zera cursor de trabalho MovAux
    *==========================================================================
    PROCEDURE InicializarCursores()
        IF USED("MovAux")
            ZAP IN MovAux
        ELSE
            CREATE CURSOR MovAux (AnoFis C(4), Datas C(8), Contas C(9), ;
                                  Debs C(12), Creds C(12), Docto C(10), ;
                                  Hists C(70), EmpCont C(3), NumSeq C(6), ;
                                  Nums C(6), Lams C(6), Data D, Valor C(12), ;
                                  Cecus C(3), Emps C(3), Transacaos C(10), ;
                                  Cpfs C(20), IClis C(10), Razaos C(50))
            INDEX ON EmpCont + Datas TAG EmpCont
            SET ORDER TO
        ENDIF
    ENDPROC

    *==========================================================================
    * Processar - Executa processamento de integracao contabil
    * par_dDataI - Data inicial do periodo
    * par_dDataF - Data final do periodo
    * Retorna .T. se concluiu sem erros fatais
    *==========================================================================
    PROCEDURE Processar(par_dDataI, par_dDataF)
        LOCAL loc_lSucesso, loc_cQuery, loc_oErro
        LOCAL loc_dDataI, loc_tDataF
        LOCAL loc_cCpoMccr
        LOCAL loc_cOcor1, loc_cOcor2, loc_cOcor3, loc_cOcor4
        LOCAL loc_nRegs, loc_oProgresso
        LOCAL loc_dDataProc, loc_nNcont, loc_nOldNopers
        LOCAL loc_cOrdMccr, loc_nRegMccr
        LOCAL loc_nDebs, loc_nCreds, loc_nValLan1, loc_nVpago, loc_nValContra
        LOCAL loc_nValorDesp, loc_nValor, loc_nVrDif, loc_nVrDeb, loc_nVrCred
        LOCAL loc_cContabs, loc_cOperacao, loc_cLcKey
        LOCAL loc_cSContas, loc_cContas, loc_cGrupos, loc_cSGrupos, loc_cEmps
        LOCAL loc_lManual, loc_nControle, loc_nControleAtu, loc_cOpeAtual, loc_cEmpLanc
        LOCAL loc_nNumlote, loc_nPLot, loc_nPNop
        LOCAL loc_lLlProvis, loc_nValOcoTit, loc_nVTitCC, loc_nValOco
        LOCAL loc_nMoeDiv, loc_nCotDiv
        LOCAL loc_cCheque, loc_cHistPrinc
        LOCAL loc_nLnOrdemHist, loc_cLcHist, loc_nTpHists
        LOCAL loc_cEspecie, loc_nNumcs, loc_cEmpDopNcs, loc_nLcKey2
        LOCAL loc_cGrpTmp, loc_cSContasTmp, loc_cContasTmp
        LOCAL loc_cGrupoPagPit, loc_cEmpDopNumsPar
        LOCAL loc_cCodEmp, loc_cNomeEmp
        LOCAL loc_cControleChm, loc_cEmpsChm, loc_nNumosChm
        LOCAL loc_cContasPit, loc_cContems
        LOCAL loc_nRecAtual
        LOCAL loc_cEmpDopNums1

        loc_lSucesso = .F.

        TRY
            loc_dDataI = par_dDataI
            loc_tDataF = DATETIME(YEAR(par_dDataF), MONTH(par_dDataF), DAY(par_dDataF), 23, 59, 59)

            THIS.this_dDataI             = par_dDataI
            THIS.this_dDataF             = par_dDataF
            THIS.this_lTemInconsistencias = .F.
            THIS.this_lTemMovimento       = .F.
            THIS.this_lTemDiferencas      = .F.

            *-- Lista de campos do SigMvCcr usada em CursorQuery equivalentes
            loc_cCpoMccr = "Emps, Nopers, Opers, Tipos, Grupos, Contas, SContas, Datas, " + ;
                           "Hists, Hist2s, Valors, Cotacaos, SValors, Valocurs, Nfs, " + ;
                           "EmpdopNums, Titulos, EspecieNfs, SGRUPOS, CONTEMS, empdopncs"

            *-- Descricoes de ocorrencias (sem literais acentuados)
            loc_cOcor1 = "Conta Cont" + CHR(225) + "bil n" + CHR(227) + "o Cadastrada "
            loc_cOcor2 = "Empresa Cont" + CHR(225) + "bil n" + CHR(227) + "o Cadastrada "
            loc_cOcor3 = "Item do Pagamento sem Centro de Custo "
            loc_cOcor4 = "PagtoXTit, Emp ou Controle n" + CHR(227) + "o encontrado"

            *-- Cursor Grupos: grupos contabilizaveis
            loc_cQuery = "SELECT Codigos, ContConts FROM SigCdGcr WHERE IntConts = 1"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "Grupos") < 1
                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (Grupos)"
            ENDIF
            SELECT Grupos
            INDEX ON Codigos TAG Codigos

            *-- Cursor crSigCdGcr: todos os grupos (IntConts + ContConts)
            loc_cQuery = "SELECT Codigos, IntConts, ContConts FROM SigCdGcr"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdGcr") < 1
                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCdGcr)"
            ENDIF
            SELECT crSigCdGcr
            INDEX ON Codigos TAG Codigos

            *-- Cursor crSigCdEmp: empresas (para validacao)
            loc_cQuery = "SELECT Cemps FROM SigCdEmp"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdEmp") < 1
                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCdEmp)"
            ENDIF
            SELECT crSigCdEmp
            INDEX ON Cemps TAG Cemps

            *-- Cursor SemConta: inconsistencias detectadas
            SET NULL ON
            CREATE CURSOR SemConta (Contas C(9), DataS D NULL, ;
                                    Hists C(70), Valors N(12,2), Ocors C(40))
            SET NULL OFF
            INDEX ON Contas + DTOS(DataS) TAG Conta

            *-- Cursor LoteProc: lotes de cheques ja processados
            CREATE CURSOR LoteProc (Lotes N(6))
            INDEX ON Lotes TAG Lotes

            *-- Cabecalho do relatorio
            loc_cCodEmp  = go_4c_Sistema.cCodEmpresa
            loc_cQuery   = "SELECT Cemps, Razas FROM SigCdEmp"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdEmpNome") < 1
                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCdEmpNome)"
            ENDIF
            loc_cNomeEmp = ""
            IF USED("crSigCdEmpNome") AND !EOF("crSigCdEmpNome")
                SELECT crSigCdEmpNome
                INDEX ON Cemps TAG Cemps
                SEEK loc_cCodEmp
                IF !EOF("crSigCdEmpNome")
                    loc_cNomeEmp = ALLTRIM(TratarNulo(Razas, "C"))
                ENDIF
            ENDIF
            IF USED("crSigCdEmpNome")
                USE IN crSigCdEmpNome
            ENDIF

            CREATE CURSOR Cabecalho (Empresa C(80), Titulo C(80), SubTit C(80), Periodo C(80))
            INSERT INTO Cabecalho (Empresa, Titulo, Periodo) ;
                VALUES (loc_cCodEmp + " - " + loc_cNomeEmp, ;
                        "Relat" + CHR(243) + "rio de Inconsist" + CHR(234) + "ncias de Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil", ;
                        "Per" + CHR(237) + "odo: " + DTOC(par_dDataI) + " " + CHR(224) + " " + DTOC(par_dDataF))

            *-- Zera MovAux antes do processamento
            IF USED("MovAux")
                ZAP IN MovAux
            ENDIF

            *-- Cursor principal: SigMvCcr no periodo (apenas SQL Server)
            loc_cQuery = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
                         "Hists, Hist2s, Valors, Opers, Autos, Nopers, Nfs, Titulos, Tipos, " + ;
                         "EmpDopNums, EspecieNfs, SGRUPOS, CONTEMS, empdopncs, EmpDopNcs, " + ;
                         "Valocurs, SValors, Cotacaos, Numcs " + ;
                         "FROM SigMvCcr " + ;
                         "WHERE Datas BETWEEN ?loc_dDataI AND ?loc_tDataF " + ;
                         "ORDER BY Datas, Nopers"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigMvCcr") < 1
                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigMvCcr)"
            ENDIF
            SELECT crSigMvCcr
            INDEX ON DataS TAG DataS
            loc_nRegs = RECCOUNT("crSigMvCcr")
            GO TOP

            *-- Variaveis de controle do loop principal
            loc_dDataProc  = CTOD("  /  /  ")
            loc_nNcont     = 0
            loc_nOldNopers = 0

            loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Dados do Cursor...", loc_nRegs)
            IF VARTYPE(loc_oProgresso) = "O"
                loc_oProgresso.Show()
            ENDIF

            *======== LOOP PRINCIPAL: SCAN crSigMvCcr ========
            SELECT crSigMvCcr
            SCAN WHILE DataS <= loc_tDataF

                IF VARTYPE(loc_oProgresso) = "O"
                    loc_oProgresso.Update(.T.)
                ENDIF

                WAIT WINDOW "Processando dia : " + DTOC(DataS) + " - " + STR(Nopers) NOWAIT

                SCATTER MEMVAR

                loc_cOrdMccr   = ORDER("crSigMvCcr")
                loc_nRegMccr   = RECNO("crSigMvCcr")
                loc_cSContas   = m.SContas
                loc_cContas    = m.Contas

                *-- Busca cliente da subconta (LocalCli)
                loc_cQuery = "SELECT IClis, Razaos, RClis, Cpfs " + ;
                             "FROM SigCdCli " + ;
                             "WHERE IClis = ?loc_cSContas " + ;
                             "ORDER BY CContabs"
                IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalCli") < 1
                    ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (LocalCli - 1)"
                ENDIF

                *-- Busca cliente da conta principal (crSigCdCli)
                loc_cQuery = "SELECT IClis, RClis, Razaos, Cpfs, IntConts, CContabs, TpHists, Hists " + ;
                             "FROM SigCdCli " + ;
                             "WHERE IClis = ?loc_cContas " + ;
                             "ORDER BY IntConts, CContabs"
                IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdCli") < 1
                    ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCdCli)"
                ENDIF

                *-- Verifica se o Grupo da Conta e contabilizavel
                SELECT Grupos
                SET ORDER TO Codigos
                loc_cGrupos = m.Grupos
                SEEK loc_cGrupos
                IF EOF() OR crSigMvCcr.Valors = 0
                    LOCAL loc_nIntConts
                    loc_nIntConts = 0
                    IF USED("crSigCdCli") AND !EOF("crSigCdCli")
                        SELECT crSigCdCli
                        loc_nIntConts = TratarNulo(IntConts, "N")
                    ENDIF
                    IF loc_nIntConts <> 1
                        SELECT crSigMvCcr
                        LOOP
                    ENDIF
                ENDIF

                *-- Verifica se a contra partida permite contabilizacao (IntConts = 3 = nao contabiliza)
                SELECT crSigCdGcr
                SET ORDER TO Codigos
                loc_cSGrupos = crSigMvCcr.Sgrupos
                SEEK loc_cSGrupos
                IF (TratarNulo(crSigCdGcr.IntConts, "N") = 3)
                    SELECT crSigMvCcr
                    LOOP
                ENDIF

                *-- Verifica empresa contabil
                SELECT crSigCdEmp
                SET ORDER TO Cemps
                loc_cEmps = crSigMvCcr.Emps
                SEEK loc_cEmps

                SELECT crSigMvCcr

                *-- Define conta contabil principal
                loc_cContabs = ""
                DO CASE
                    CASE !EMPTY(Grupos.ContConts)
                        loc_cContabs = Grupos.ContConts

                    CASE USED("crSigCdCli") AND !EOF("crSigCdCli") AND !EMPTY(crSigCdCli.CContabs)
                        loc_cContabs = crSigCdCli.CContabs

                    OTHERWISE
                        loc_cContabs = m.Contas

                        SELECT SemConta
                        APPEND BLANK
                        REPLACE DataS  WITH crSigMvCcr.DataS, ;
                                Contas WITH crSigMvCcr.Contas, ;
                                Hists  WITH crSigMvCcr.Hists + crSigMvCcr.Hist2s, ;
                                Valors WITH crSigMvCcr.Valors, ;
                                Ocors  WITH loc_cOcor1

                        SELECT crSigMvCcr
                ENDCASE

                IF (crSigMvCcr.Opers = "D")
                    loc_nDebs  = crSigMvCcr.Valors
                    loc_nCreds = 0
                ELSE
                    loc_nDebs  = 0
                    loc_nCreds = crSigMvCcr.Valors
                ENDIF

                loc_nValLan1 = crSigMvCcr.Valors

                m.AnoFis  = STR(YEAR(crSigMvCcr.DataS), 4)
                m.Datas   = STRTRAN(DTOC(crSigMvCcr.DataS), "/", "")
                m.Contas  = loc_cContabs
                m.Debs    = TRANS(loc_nDebs  * 100, "@L 999999999999")
                m.Creds   = TRANS(loc_nCreds * 100, "@L 999999999999")
                m.Hists   = SUBSTR(Hists + Hist2s, 1, 70)
                m.Hists   = STRTRAN(m.Hists, CHR(1),  "")
                m.Hists   = STRTRAN(m.Hists, CHR(13), "")
                m.Hists   = STRTRAN(m.Hists, CHR(10), "")
                m.Emps    = crSigMvCcr.Emps
                m.Nfs     = crSigMvCcr.Nfs
                m.Cecus   = crSigMvCcr.Emps

                loc_cHistPrinc = Hist2s

                *-- Tratamento de lote de cheques
                loc_nNumlote = 0
                IF Autos AND "LOTE" $ Hists
                    m.Docto      = VAL(RIGHT(ALLTRIM(Hists), 6))
                    loc_nNumlote = VAL(SUBSTR(Hists, AT("LOTE", Hists) + 5, 6))
                    IF loc_nNumlote = 0
                        loc_nNumlote = VAL(RIGHT(ALLTRIM(Hists), 6))
                    ENDIF
                    SELECT LoteProc
                    SEEK loc_nNumlote
                    IF !EOF()
                        SELECT crSigMvCcr
                        LOOP
                    ENDIF
                    SELECT crSigMvCcr
                ELSE
                    m.Docto = m.Nfs
                ENDIF

                IF crSigMvCcr.Nopers <> loc_nOldNopers
                    loc_nNcont     = loc_nNcont + 1
                    loc_nOldNopers = crSigMvCcr.Nopers
                ENDIF
                m.Transacaos = TRANS(loc_nNcont, "@L 999999")
                m.IClis      = TratarNulo(LocalCli.IClis,  "C")
                m.Razaos     = IIF(EMPTY(TratarNulo(LocalCli.Razaos, "C")), ;
                                   TratarNulo(LocalCli.RClis, "C"), ;
                                   TratarNulo(LocalCli.Razaos, "C"))
                m.Cpfs       = TratarNulo(LocalCli.Cpfs, "C")

                *-- Lancamento 1
                SELECT MovAux
                APPEND BLANK
                GATHER MEMVAR

                IF (Nopers = 1)
                    SELECT crSigMvCcr
                    LOOP
                ENDIF

                SELECT crSigMvCcr

                *-- Lancamento 2: variaveis de controle do par de lancamentos
                loc_nRecAtual    = RECNO("crSigMvCcr")
                loc_cOpeAtual    = crSigMvCcr.Opers
                loc_nControle    = crSigMvCcr.Nopers
                loc_nControleAtu = crSigMvCcr.Nopers
                loc_cEmpLanc     = crSigMvCcr.Emps
                loc_lManual      = .F.

                *-- Verifica se existe lancamento Manual (Tipo = "M")
                loc_cQuery = "SELECT " + loc_cCpoMccr + " FROM SigMvCcr WHERE Nopers = ?loc_nControle"
                IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMccr") < 1
                    ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpMccr - tipo M)"
                ENDIF
                SELECT TmpMccr
                SCAN
                    IF TIPOS = "M"
                        loc_lManual = .T.
                        EXIT
                    ENDIF
                ENDSCAN

                DO CASE
                    *-- CASO 1: Lancamento por lote de cheques
                    CASE crSigMvCcr.Autos AND "LOTE" $ Hists

                        SELECT LoteProc
                        SEEK loc_nNumlote
                        IF !EOF()
                            SELECT crSigMvCcr
                            LOOP
                        ELSE
                            APPEND BLANK
                            REPLACE Lotes WITH loc_nNumlote
                        ENDIF

                        loc_nPLot  = loc_nNumlote
                        loc_cQuery = "SELECT Emps, NumOs FROM SigCqChm WHERE NumLotes = ?loc_nPLot"
                        IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigCqChm") < 1
                            IF USED("crSigMvCcr")
                                USE IN crSigMvCcr
                            ENDIF
                            ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCqChm)"
                        ENDIF

                        SELECT crSigCqChm
                        SCAN
                            loc_cEmpsChm  = ALLTRIM(crSigCqChm.Emps)
                            loc_nNumosChm = crSigCqChm.Numos

                            loc_cQuery = "SELECT " + loc_cCpoMccr + " FROM SigMvCcr " + ;
                                         "WHERE Nopers = ?loc_nNumosChm"
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMccr") < 1
                                loc_cEmpsChm = ALLTRIM(loc_cEmpLanc)
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMccr") < 1
                                    SELECT crSigCqChm
                                    LOOP
                                ENDIF
                            ENDIF

                            IF USED("TmpMccr") AND !EOF("TmpMccr")
                                SELECT TmpMccr
                                SCAN
                                    IF (Opers <> loc_cOpeAtual OR loc_nControleAtu <> TmpMccr.Nopers) AND ;
                                            (Grupos <> THIS.this_cGrupoPags) AND ;
                                            (Grupos <> THIS.this_cGrupoRecs)

                                        SELECT crSigCdGcr
                                        SET ORDER TO Codigos
                                        loc_cGrpTmp = TmpMccr.Grupos
                                        SEEK loc_cGrpTmp

                                        loc_cSContasTmp = TmpMccr.SContas
                                        loc_cContasTmp  = TmpMccr.Contas

                                        loc_cQuery = "SELECT IClis, RClis, Razaos, Cpfs " + ;
                                                     "FROM SigCdCli WHERE IClis = ?loc_cSContasTmp ORDER BY CContabs"
                                        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalCli") < 1
                                            ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (LocalCli - 2)"
                                        ENDIF

                                        loc_cQuery = "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists " + ;
                                                     "FROM SigCdCli WHERE IClis = ?loc_cContasTmp ORDER BY CContabs"
                                        IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCli") < 1
                                            ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCdCli - 1)"
                                        ENDIF

                                        DO CASE
                                            CASE !EMPTY(crSigCdGcr.ContConts)
                                                loc_cContabs = crSigCdGcr.ContConts
                                            CASE USED("TmpCli") AND !EOF("TmpCli") AND !EMPTY(TmpCli.CContabs)
                                                loc_cContabs = TmpCli.CContabs
                                            OTHERWISE
                                                loc_cContabs = TmpMccr.Contas
                                                SELECT SemConta
                                                APPEND BLANK
                                                REPLACE DataS  WITH TmpMccr.DataS, ;
                                                        Contas WITH TmpMccr.Contas, ;
                                                        Hists  WITH TmpMccr.Hists + TmpMccr.Hist2s, ;
                                                        Valors WITH TmpMccr.Valors, ;
                                                        Ocors  WITH loc_cOcor1
                                        ENDCASE

                                        SELECT TmpMccr
                                        IF (TmpMccr.Opers = "D")
                                            loc_nDebs  = TmpMccr.Valors
                                            loc_nCreds = 0
                                        ELSE
                                            loc_nDebs  = 0
                                            loc_nCreds = TmpMccr.Valors
                                        ENDIF

                                        m.Contas = loc_cContabs
                                        m.Debs   = TRANS(loc_nDebs  * 100, "@L 999999999999")
                                        m.Creds  = TRANS(loc_nCreds * 100, "@L 999999999999")
                                        m.Hists  = SUBSTR(ALLTRIM(Hists) + " " + Hist2s, 1, 70)
                                        m.Hists  = STRTRAN(m.Hists, CHR(1),  "")
                                        m.Hists  = STRTRAN(m.Hists, CHR(13), "")
                                        m.Hists  = STRTRAN(m.Hists, CHR(10), "")
                                        m.Emps   = TmpMccr.Emps
                                        m.Cecus  = TmpMccr.Emps
                                        m.IClis  = TratarNulo(LocalCli.IClis,  "C")
                                        m.Razaos = IIF(EMPTY(TratarNulo(LocalCli.Razaos, "C")), ;
                                                       TratarNulo(LocalCli.RClis, "C"), ;
                                                       TratarNulo(LocalCli.Razaos, "C"))
                                        m.Cpfs   = TratarNulo(LocalCli.Cpfs, "C")

                                        SELECT MovAux
                                        APPEND BLANK
                                        GATHER MEMVAR
                                    ENDIF
                                    SELECT TmpMccr
                                ENDSCAN
                            ENDIF
                            SELECT crSigCqChm
                        ENDSCAN

                        SELECT crSigMvCcr
                        SET ORDER TO loc_cOrdMccr
                        GO loc_nRegMccr

                    *-- CASO 2: Nao-PAGAMENTO/RECEBIMENTO ou lancamento Manual
                    CASE (crSigMvCcr.Dopes <> "PAGAMENTO"   AND crSigMvCcr.Dopes <> "RECEBIMENTO") OR ;
                         (crSigMvCcr.Dopes  = "PAGAMENTO"   AND loc_lManual) OR ;
                         (crSigMvCcr.Dopes  = "RECEBIMENTO" AND loc_lManual)

                        loc_cQuery = "SELECT " + loc_cCpoMccr + " FROM SigMvCcr WHERE Nopers = ?loc_nControle"
                        IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMccr") < 1
                            ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpMccr - nopers)"
                        ENDIF

                        SELECT TmpMccr
                        SCAN
                            LOCAL loc_cGrpTmpMccr
                            loc_cGrpTmpMccr = TmpMccr.Grupos
                            IF SEEK(loc_cGrpTmpMccr, "Grupos", "Codigos")
                                LOOP
                            ENDIF

                            IF (Opers <> loc_cOpeAtual) AND ;
                                    (Grupos <> THIS.this_cGrupoPags) AND ;
                                    (Grupos <> THIS.this_cGrupoRecs)

                                WAIT WINDOW "Processando dia : " + DTOC(DataS) + " - " + STR(Nopers) NOWAIT

                                IF (DataS <> loc_dDataProc)
                                    loc_dDataProc = DataS
                                ENDIF

                                SELECT crSigCdGcr
                                SET ORDER TO Codigos
                                loc_cGrpTmp = TmpMccr.Grupos
                                SEEK loc_cGrpTmp

                                loc_cSContasTmp = TmpMccr.SContas
                                loc_cQuery = "SELECT IClis, RClis, Razaos, Cpfs " + ;
                                             "FROM SigCdCli WHERE IClis = ?loc_cSContasTmp ORDER BY CContabs"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalCli") < 1
                                    ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (LocalCli - 5)"
                                ENDIF

                                loc_cContasTmp = TmpMccr.Contas
                                loc_cQuery = "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists " + ;
                                             "FROM SigCdCli WHERE IClis = ?loc_cContasTmp ORDER BY CContabs"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCli") < 1
                                    ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCdCli - 4)"
                                ENDIF

                                DO CASE
                                    CASE !EMPTY(crSigCdGcr.ContConts)
                                        loc_cContabs = crSigCdGcr.ContConts
                                    CASE USED("TmpCli") AND !EOF("TmpCli") AND !EMPTY(TmpCli.CContabs)
                                        loc_cContabs = TmpCli.CContabs
                                    OTHERWISE
                                        loc_cContabs = TmpMccr.Contas
                                        SELECT SemConta
                                        APPEND BLANK
                                        REPLACE DataS  WITH TmpMccr.DataS, ;
                                                Contas WITH TmpMccr.Contas, ;
                                                Hists  WITH TmpMccr.Hists + TmpMccr.Hist2s, ;
                                                Valors WITH TmpMccr.Valors, ;
                                                Ocors  WITH loc_cOcor1
                                ENDCASE

                                SELECT TmpMccr
                                IF (TmpMccr.Opers = "D")
                                    loc_nDebs  = IIF(TmpMccr.COTACAOS <> 0 AND TmpMccr.COTACAOS <> 1, ;
                                                     TmpMccr.SVALORS, TmpMccr.Valors)
                                    loc_nCreds = 0
                                ELSE
                                    loc_nDebs  = 0
                                    loc_nCreds = IIF(TmpMccr.COTACAOS <> 0 AND TmpMccr.COTACAOS <> 1, ;
                                                     TmpMccr.SVALORS, TmpMccr.Valors)
                                ENDIF

                                m.Contas = loc_cContabs
                                m.Debs   = TRANS(loc_nDebs  * 100, "@L 999999999999")
                                m.Creds  = TRANS(loc_nCreds * 100, "@L 999999999999")
                                m.Docto  = m.Nfs
                                m.Hists  = SUBSTR(ALLTRIM(Hists) + " " + Hist2s, 1, 70)
                                m.Hists  = STRTRAN(m.Hists, CHR(1),  "")
                                m.Hists  = STRTRAN(m.Hists, CHR(13), "")
                                m.Hists  = STRTRAN(m.Hists, CHR(10), "")
                                m.Emps   = TmpMccr.Emps
                                m.Cecus  = TmpMccr.Emps
                                m.IClis  = TratarNulo(LocalCli.IClis,  "C")
                                m.Razaos = IIF(EMPTY(TratarNulo(LocalCli.Razaos, "C")), ;
                                               TratarNulo(LocalCli.RClis, "C"), ;
                                               TratarNulo(LocalCli.Razaos, "C"))
                                m.Cpfs   = TratarNulo(LocalCli.Cpfs, "C")

                                SELECT MovAux
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDSCAN

                    *-- CASO 3: PAGAMENTO ou RECEBIMENTO (nao manual) com rateio por titulo
                    OTHERWISE

                        loc_cOperacao  = Dopes
                        loc_nValorDesp = 0

                        WAIT WINDOW "Processando dia : " + DTOC(DataS) + " - " + STR(Nopers) NOWAIT

                        SELECT crSigMvCcr
                        SET ORDER TO loc_cOrdMccr
                        GO loc_nRegMccr

                        loc_cLcKey     = crSigMvCcr.Emps + crSigMvCcr.Dopes + STR(crSigMvCcr.Numes, 6)
                        loc_cEmpDopNums1 = loc_cLcKey

                        *-- PRIMEIRO SCAN crSigCdPit: calcula ValorDesp e detecta inconsistencias
                        loc_cQuery = "SELECT * FROM SigCdPit WHERE EmpDopNums = ?loc_cEmpDopNums1"
                        IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdPit") < 1
                            ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCdPit)"
                        ENDIF

                        SELECT crSigCdPit
                        SCAN
                            IF (loc_cOperacao = "PAGAMENTO"   AND Opers = "D") OR ;
                                    (loc_cOperacao = "RECEBIMENTO" AND Opers = "C")
                                LOOP
                            ENDIF

                            loc_nVTitCC = 0
                            loc_nValOco = 0
                            loc_nMoeDiv = Moedas
                            loc_nCotDiv = COTACAOS
                            loc_nPNop   = crSigCdPit.Nopers

                            loc_cQuery = "SELECT * FROM SigMvCcr WHERE Nopers = ?loc_nPNop"
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMccr1") < 1
                                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpMccr1)"
                            ENDIF

                            loc_cEspecie = ""
                            IF USED("TmpMccr1") AND !EOF("TmpMccr1")
                                SELECT TmpMccr1
                                loc_cEspecie = ALLTRIM(TratarNulo(ESPECIENFS, "C"))
                            ENDIF

                            loc_cQuery = "SELECT provs FROM SigCdEsp WHERE especies = ?loc_cEspecie"
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpEspes") < 1
                                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpEspes)"
                            ENDIF

                            loc_lLlProvis = .T.
                            IF USED("TmpEspes") AND RECCOUNT("TmpEspes") > 0 AND !EOF("TmpEspes")
                                SELECT TmpEspes
                                IF TmpEspes.provs <> 1
                                    loc_lLlProvis = .F.
                                ENDIF
                            ENDIF

                            SELECT TmpMccr1
                            GO TOP
                            IF !EOF()
                                loc_nNumcs     = TratarNulo(TmpMccr1.Numcs, "N")
                                loc_cEmpDopNcs = ALLTRIM(TratarNulo(TmpMccr1.EmpDopNcs, "C"))

                                IF loc_nNumcs = 0
                                    loc_nLcKey2 = TmpMccr1.Nopers
                                    loc_cQuery = "SELECT " + loc_cCpoMccr + " FROM SigMvCcr WHERE Nopers = ?loc_nLcKey2"
                                ELSE
                                    loc_cQuery = "SELECT " + loc_cCpoMccr + " FROM SigMvCcr WHERE Nopers = ?loc_nPNop"
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMccr") < 1
                                    ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpMccr - EmpDopNcs)"
                                ENDIF

                                loc_nValOcoTit = 0

                                SELECT TmpMccr
                                SCAN
                                    IF TIPOS = "O"
                                        LOOP
                                    ENDIF

                                    IF (TmpMccr.Grupos = THIS.this_cGrupoPags) OR ;
                                            (TmpMccr.Grupos = THIS.this_cGrupoRecs)
                                        IF TmpMccr.Valocurs <> 0
                                            IF loc_nMoeDiv <> THIS.this_cMoedaCheqs
                                                loc_nValOco = loc_nValOco + ROUND(TmpMccr.Valocurs * loc_nCotDiv, 2)
                                            ELSE
                                                loc_nValOco = loc_nValOco + TmpMccr.Valocurs
                                            ENDIF
                                        ENDIF
                                        LOOP
                                    ENDIF

                                    IF (loc_cOperacao = "PAGAMENTO"   AND Opers = "D") OR ;
                                            (loc_cOperacao = "RECEBIMENTO" AND Opers = "C")
                                        IF loc_nMoeDiv <> THIS.this_cMoedaCheqs
                                            loc_nValor = ROUND((TmpMccr.Valors + TmpMccr.Valocurs) * loc_nCotDiv, 2)
                                        ELSE
                                            loc_nValor = TmpMccr.Valors + TmpMccr.Valocurs
                                        ENDIF
                                        loc_nValorDesp = loc_nValorDesp + loc_nValor
                                        loc_nVTitCC    = loc_nVTitCC    + loc_nValor
                                    ENDIF
                                ENDSCAN

                                loc_nValorDesp = loc_nValorDesp + loc_nValOco

                                IF loc_nVTitCC = 0
                                    LOCAL loc_cContas1, loc_cSContas1, loc_dDataMccr1
                                    loc_cContas1  = ""
                                    loc_cSContas1 = ""
                                    loc_dDataMccr1 = {^1900-01-01}
                                    IF USED("TmpMccr1") AND !EOF("TmpMccr1")
                                        SELECT TmpMccr1
                                        loc_cContas1   = ALLTRIM(TratarNulo(Contas,  "C"))
                                        loc_cSContas1  = ALLTRIM(TratarNulo(SContas, "C"))
                                        loc_dDataMccr1 = TratarNulo(DataS, "D")
                                    ENDIF
                                    SELECT SemConta
                                    APPEND BLANK
                                    REPLACE DataS  WITH loc_dDataMccr1, ;
                                            Contas WITH IIF(!loc_lLlProvis, loc_cContas1, loc_cSContas1), ;
                                            Hists  WITH crSigCdPit.Emps + " / " + crSigCdPit.Dopes + " / " + ;
                                                        STR(crSigCdPit.Numes, 6) + crSigCdPit.Hists, ;
                                            Valors WITH crSigCdPit.Acertos, ;
                                            Ocors  WITH loc_cOcor3
                                ENDIF
                            ELSE
                                LOCAL loc_cContasInc, loc_cSContasInc, loc_dDataInc
                                loc_cContasInc  = ""
                                loc_cSContasInc = ""
                                loc_dDataInc    = {^1900-01-01}
                                IF USED("TmpMccr1")
                                    SELECT TmpMccr1
                                    GO TOP
                                    IF !EOF()
                                        loc_cContasInc  = ALLTRIM(TratarNulo(Contas,  "C"))
                                        loc_cSContasInc = ALLTRIM(TratarNulo(SContas, "C"))
                                        loc_dDataInc    = TratarNulo(DataS, "D")
                                    ENDIF
                                ENDIF
                                SELECT SemConta
                                APPEND BLANK
                                REPLACE DataS  WITH loc_dDataInc, ;
                                        Contas WITH IIF(!loc_lLlProvis, loc_cContasInc, loc_cSContasInc), ;
                                        Hists  WITH crSigCdPit.Emps + " / " + crSigCdPit.Dopes + " / " + ;
                                                    STR(crSigCdPit.Numes, 6) + crSigCdPit.Hists, ;
                                        Valors WITH crSigCdPit.Acertos, ;
                                        Ocors  WITH loc_cOcor4
                            ENDIF
                            SELECT crSigCdPit
                        ENDSCAN

                        *-- Proporcao do valor pago sobre as despesas
                        IF loc_nValorDesp <> 0
                            loc_nVpago = loc_nValLan1 / loc_nValorDesp
                        ELSE
                            loc_nVpago = 1
                        ENDIF

                        *-- Reposiciona crSigMvCcr e re-busca crSigCdPit para lancamentos com rateio
                        SELECT crSigMvCcr
                        SET ORDER TO loc_cOrdMccr
                        GO loc_nRegMccr
                        loc_cLcKey     = crSigMvCcr.Emps + crSigMvCcr.Dopes + STR(crSigMvCcr.Numes, 6)
                        loc_cEmpDopNums1 = loc_cLcKey

                        loc_cQuery = "SELECT * FROM SigCdPit WHERE EmpDopNums = ?loc_cEmpDopNums1"
                        IF SQLEXEC(gnConnHandle, loc_cQuery, "crSigCdPit") < 1
                            ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCdPit - 2)"
                        ENDIF

                        loc_nValContra = 0

                        *-- SEGUNDO SCAN crSigCdPit: lancamentos com rateio
                        SELECT crSigCdPit
                        SCAN
                            IF (loc_cOperacao = "PAGAMENTO"   AND Opers = "D") OR ;
                                    (loc_cOperacao = "RECEBIMENTO" AND Opers = "C")
                                LOOP
                            ENDIF

                            loc_nMoeDiv      = Moedas
                            loc_nCotDiv      = COTACAOS
                            loc_nPNop        = crSigCdPit.Nopers
                            loc_cGrupoPagPit = ALLTRIM(TratarNulo(crSigCdPit.Grupos, "C"))

                            loc_cQuery = "SELECT * FROM SigMvCcr WHERE Nopers = ?loc_nPNop"
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMccr1") < 1
                                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpMccr1 - 2)"
                            ENDIF

                            loc_cEspecie = ""
                            IF USED("TmpMccr1") AND !EOF("TmpMccr1")
                                SELECT TmpMccr1
                                loc_cEspecie = ALLTRIM(TratarNulo(ESPECIENFS, "C"))
                            ENDIF

                            loc_cQuery = "SELECT provs FROM SigCdEsp WHERE especies = ?loc_cEspecie"
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpEspes") < 1
                                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpEspes - 2)"
                            ENDIF

                            loc_lLlProvis = .T.
                            IF USED("TmpEspes") AND RECCOUNT("TmpEspes") > 0 AND !EOF("TmpEspes")
                                SELECT TmpEspes
                                IF TmpEspes.provs <> 1
                                    loc_lLlProvis = .F.
                                ENDIF
                            ENDIF

                            SELECT TmpMccr1
                            GO TOP
                            IF !EOF()
                                loc_nNumcs     = TratarNulo(TmpMccr1.Numcs, "N")
                                loc_cEmpDopNcs = ALLTRIM(TratarNulo(TmpMccr1.EmpDopNcs, "C"))

                                IF loc_nNumcs = 0
                                    loc_nLcKey2 = TmpMccr1.Nopers
                                    loc_cQuery = "SELECT " + loc_cCpoMccr + " FROM SigMvCcr WHERE Nopers = ?loc_nLcKey2 ORDER BY Tipos"
                                ELSE
                                    loc_cQuery = "SELECT " + loc_cCpoMccr + " FROM SigMvCcr WHERE Nopers = ?loc_nPNop ORDER BY Tipos"
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMccr") < 1
                                    ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpMccr - rateio)"
                                ENDIF

                                loc_nValOcoTit = 0

                                SELECT TmpMccr
                                SCAN
                                    IF (TmpMccr.Grupos = THIS.this_cGrupoPags) OR ;
                                            (TmpMccr.Grupos = THIS.this_cGrupoRecs) OR ;
                                            (TIPOS = "O")
                                        IF !TmpMccr.TIPOS = "O"
                                            loc_nValOcoTit = loc_nValOcoTit + TmpMccr.Valocurs
                                        ENDIF
                                        LOOP
                                    ENDIF

                                    IF (loc_cOperacao = "PAGAMENTO"   AND Opers = "D") OR ;
                                            (loc_cOperacao = "RECEBIMENTO" AND Opers = "C")

                                        SELECT crSigCdGcr
                                        SET ORDER TO Codigos

                                        LOCAL loc_cGrpSeek
                                        IF !loc_lLlProvis
                                            loc_cGrpSeek = TmpMccr.Grupos
                                        ELSE
                                            loc_cGrpSeek = loc_cGrupoPagPit
                                        ENDIF
                                        SEEK loc_cGrpSeek

                                        loc_cSContasTmp = TmpMccr.SContas
                                        loc_cContasTmp  = TmpMccr.Contas

                                        loc_cQuery = "SELECT Ccontabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists " + ;
                                                     "FROM SigCdCli WHERE IClis = ?loc_cSContasTmp ORDER BY CContabs"
                                        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalCli") < 1
                                            ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (LocalCli - 6)"
                                        ENDIF

                                        loc_cQuery = "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists " + ;
                                                     "FROM SigCdCli WHERE IClis = ?loc_cContasTmp ORDER BY CContabs"
                                        IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCli") < 1
                                            ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigCdCli - 6)"
                                        ENDIF

                                        *-- Numero do cheque do pagamento
                                        loc_cEmpDopNumsPar = crSigMvCcr.EmpDopnums
                                        loc_cQuery = "SELECT numeros FROM SigMvPar A, SigOpFp B, SigCdFrm C " + ;
                                                     "WHERE A.EmpDopNUms = ?loc_cEmpDopNumsPar " + ;
                                                     "AND A.FPAGS = B.FPAGS AND B.FORMAS = C.FORMAS AND C.INFOS = 'C'"
                                        IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpPar") < 1
                                            ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (crSigMvPar)"
                                        ENDIF

                                        IF !loc_lLlProvis
                                            DO CASE
                                                CASE !EMPTY(crSigCdGcr.ContConts)
                                                    loc_cContabs = crSigCdGcr.ContConts
                                                CASE USED("TmpCli") AND !EOF("TmpCli") AND !EMPTY(TmpCli.CContabs)
                                                    loc_cContabs = TmpCli.CContabs
                                                OTHERWISE
                                                    loc_cContabs = TmpMccr.Contas
                                                    SELECT SemConta
                                                    APPEND BLANK
                                                    REPLACE DataS  WITH TmpMccr.DataS, ;
                                                            Contas WITH TmpMccr.Contas, ;
                                                            Hists  WITH TmpMccr.Hists + TmpMccr.Hist2s, ;
                                                            Valors WITH TmpMccr.Valors, ;
                                                            Ocors  WITH loc_cOcor1
                                                    SELECT TmpMccr
                                            ENDCASE
                                        ELSE
                                            DO CASE
                                                CASE !EMPTY(crSigCdGcr.ContConts)
                                                    loc_cContabs = crSigCdGcr.ContConts
                                                CASE USED("LocalCli") AND !EOF("LocalCli") AND !EMPTY(LocalCli.CContabs)
                                                    loc_cContabs = LocalCli.CContabs
                                                OTHERWISE
                                                    loc_cContabs = TmpMccr.Contas
                                                    SELECT SemConta
                                                    APPEND BLANK
                                                    REPLACE DataS  WITH TmpMccr.DataS, ;
                                                            Contas WITH TmpMccr.Contas, ;
                                                            Hists  WITH TmpMccr.Hists + TmpMccr.Hist2s, ;
                                                            Valors WITH TmpMccr.Valors, ;
                                                            Ocors  WITH loc_cOcor1
                                                    SELECT TmpMccr
                                            ENDCASE
                                        ENDIF

                                        SELECT TmpMccr
                                        IF loc_nMoeDiv <> THIS.this_cMoedaCheqs
                                            loc_nValor = ROUND((TmpMccr.Valors + loc_nValOcoTit) * loc_nCotDiv, 2)
                                        ELSE
                                            loc_nValor = TmpMccr.Valors + loc_nValOcoTit
                                        ENDIF

                                        *-- Rateio do valor pago
                                        loc_nValor = ROUND(loc_nValor * loc_nVpago, 2)
                                        loc_nValContra = loc_nValContra + loc_nValor

                                        IF TmpMccr.Opers = "D"
                                            loc_nDebs  = loc_nValor
                                            loc_nCreds = 0
                                        ELSE
                                            loc_nDebs  = 0
                                            loc_nCreds = loc_nValor
                                        ENDIF

                                        m.Contas = loc_cContabs
                                        m.Debs   = TRANS(loc_nDebs  * 100, "@L 999999999999")
                                        m.Creds  = TRANS(loc_nCreds * 100, "@L 999999999999")
                                        m.Docto  = TmpMccr.Titulos
                                        m.Emps   = TmpMccr.Emps
                                        m.Cecus  = TmpMccr.Emps
                                        m.IClis  = TratarNulo(LocalCli.IClis,  "C")
                                        m.Razaos = SUBSTR(IIF(EMPTY(TratarNulo(LocalCli.Razaos, "C")), ;
                                                              TratarNulo(LocalCli.RClis, "C"), ;
                                                              TratarNulo(LocalCli.Razaos, "C")), 1, 20)
                                        m.Cpfs   = TratarNulo(TmpCli.Cpfs, "C")

                                        IF USED("TmpPar") AND !EOF("TmpPar")
                                            SELECT TmpPar
                                            loc_cCheque = IIF(TmpPar.Numeros <> " ", "-Chq:" + TmpPar.Numeros, " ")
                                        ELSE
                                            loc_cCheque = " "
                                        ENDIF

                                        IF (THIS.this_nCfgHisICs = 2)
                                            loc_cHistPrinc = IIF(LEN(ALLTRIM(TmpMccr.Hist2s)) = 0, "", "-" + ALLTRIM(TmpMccr.Hist2s))

                                            loc_cContasPit = ALLTRIM(TratarNulo(crSigCdPit.Contas, "C"))
                                            loc_cQuery = "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists " + ;
                                                         "FROM SigCdCli WHERE IClis = ?loc_cContasPit ORDER BY CContabs"
                                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCliPrit") < 1
                                                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpCliPrit)"
                                            ENDIF

                                            loc_cContems = ALLTRIM(TratarNulo(TmpMccr1.CONTEMS, "C"))
                                            loc_cQuery = "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists " + ;
                                                         "FROM SigCdCli WHERE IClis = ?loc_cContems ORDER BY CContabs"
                                            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCliCONTEMS") < 1
                                                ERROR "Favor Reinicializar o Processo! Falha na conex" + CHR(227) + "o (TmpCliCONTEMS)"
                                            ENDIF

                                            m.Hists          = PROPER(SUBSTR(loc_cOperacao, 1, 3))
                                            loc_nLnOrdemHist = 1
                                            loc_cLcHist      = ""

                                            loc_nTpHists = 0
                                            IF USED("TmpCliPrit") AND !EOF("TmpCliPrit")
                                                SELECT TmpCliPrit
                                                loc_nTpHists = TratarNulo(tphists, "N")
                                            ENDIF

                                            DO CASE
                                                CASE loc_nTpHists = 1
                                                    IF USED("TmpCliCONTEMS") AND !EOF("TmpCliCONTEMS")
                                                        SELECT TmpCliCONTEMS
                                                        m.Razaos = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(Razaos, "C")), ;
                                                                                       TratarNulo(RClis, "C"), ;
                                                                                       TratarNulo(Razaos, "C")), 1, 20))
                                                    ENDIF
                                                    IF USED("TmpCliPrit") AND !EOF("TmpCliPrit")
                                                        SELECT TmpCliPrit
                                                        IF LEN(ALLTRIM(TratarNulo(Hists, "C"))) <> 0
                                                            loc_cLcHist = ALLTRIM(TratarNulo(Hists, "C")) + " " + ALLTRIM(TmpMccr.Nfs)
                                                        ELSE
                                                            loc_cLcHist = ALLTRIM(TmpMccr.Nfs)
                                                        ENDIF
                                                    ENDIF
                                                    loc_nLnOrdemHist = 1

                                                CASE loc_nTpHists = 2
                                                    IF USED("TmpCliCONTEMS") AND !EOF("TmpCliCONTEMS")
                                                        SELECT TmpCliCONTEMS
                                                        m.Razaos = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(Razaos, "C")), ;
                                                                                       TratarNulo(RClis, "C"), ;
                                                                                       TratarNulo(Razaos, "C")), 1, 20))
                                                    ENDIF
                                                    IF USED("TmpCliPrit") AND !EOF("TmpCliPrit")
                                                        SELECT TmpCliPrit
                                                        IF LEN(ALLTRIM(TratarNulo(Hists, "C"))) <> 0
                                                            loc_cLcHist = ALLTRIM(TratarNulo(Hists, "C")) + " " + ALLTRIM(TmpMccr.Titulos)
                                                        ELSE
                                                            loc_cLcHist = ALLTRIM(TmpMccr.Titulos)
                                                        ENDIF
                                                    ENDIF
                                                    loc_nLnOrdemHist = 1

                                                CASE loc_nTpHists = 3
                                                    IF USED("TmpCliPrit") AND !EOF("TmpCliPrit")
                                                        SELECT TmpCliPrit
                                                        IF LEN(ALLTRIM(TratarNulo(Hists, "C"))) <> 0
                                                            loc_cLcHist = ALLTRIM(TratarNulo(Hists, "C")) + " " + SUBSTR(DTOC(TmpMccr.DataS), 4, 7)
                                                        ELSE
                                                            loc_cLcHist = SUBSTR(DTOC(TmpMccr.DataS), 4, 7)
                                                        ENDIF
                                                    ENDIF
                                                    IF USED("TmpCliCONTEMS") AND !EOF("TmpCliCONTEMS")
                                                        SELECT TmpCliCONTEMS
                                                        m.Razaos = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(Razaos, "C")), ;
                                                                                       TratarNulo(RClis, "C"), ;
                                                                                       TratarNulo(Razaos, "C")), 1, 20))
                                                    ENDIF
                                                    loc_nLnOrdemHist = 2

                                                CASE loc_nTpHists = 4
                                                    *-- Nenhum historico configurado

                                                OTHERWISE
                                                    loc_cLcHist = ALLTRIM(m.Docto)
                                                    IF USED("TmpCliCONTEMS") AND !EOF("TmpCliCONTEMS")
                                                        SELECT TmpCliCONTEMS
                                                        m.Razaos = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(Razaos, "C")), ;
                                                                                       TratarNulo(RClis, "C"), ;
                                                                                       TratarNulo(Razaos, "C")), 1, 20))
                                                    ENDIF
                                            ENDCASE

                                            DO CASE
                                                CASE loc_nLnOrdemHist = 1
                                                    m.Hists = m.Hists + " " + loc_cLcHist + "-" + ALLTRIM(m.Razaos) + " " + loc_cCheque + " "
                                                CASE loc_nLnOrdemHist = 2
                                                    m.Hists = m.Hists + " " + ALLTRIM(m.Razaos) + " " + loc_cLcHist + " " + loc_cCheque + " "
                                            ENDCASE
                                        ELSE
                                            m.Hists = SUBSTR(TmpMccr.Emps + "-" + Hists + Hist2s, 1, 70)
                                        ENDIF

                                        m.Hists = STRTRAN(STRTRAN(STRTRAN(m.Hists, CHR(1), ""), CHR(13), ""), CHR(10), "")

                                        SELECT MovAux
                                        APPEND BLANK
                                        GATHER MEMVAR
                                    ENDIF
                                ENDSCAN
                            ENDIF
                            SELECT crSigCdPit
                        ENDSCAN

                        *-- Acerto da diferenca de rateio
                        loc_nVrDif = loc_nValLan1 - loc_nValContra

                        IF (loc_nVrDif <> 0)
                            SELECT MovAux
                            IF VAL(Debs) <> 0
                                loc_nVrDeb = (VAL(Debs) / 100) + loc_nVrDif
                                m.Debs = TRANS(loc_nVrDeb * 100, "@L 999999999999")
                                REPLACE Debs WITH m.Debs
                            ELSE
                                loc_nVrCred = (VAL(Creds) / 100) + loc_nVrDif
                                m.Creds = TRANS(loc_nVrCred * 100, "@L 999999999999")
                                REPLACE Creds WITH m.Creds
                            ENDIF
                        ENDIF

                ENDCASE

                *-- Reposiciona crSigMvCcr no registro corrente
                SELECT crSigMvCcr
                SET ORDER TO loc_cOrdMccr
                GO loc_nRegMccr

                *-- Remove lancamentos PAGAMENTO/RECEBIMENTO ja processados para nao duplicar
                LOCAL loc_cDopes, loc_cChaveDel
                loc_cDopes    = Dopes
                loc_cChaveDel = EmpDopnums
                IF loc_cDopes = "PAGAMENTO" OR loc_cDopes = "RECEBIMENTO"
                    DELETE FOR EmpDopnums = loc_cChaveDel
                    GO loc_nRegMccr
                ENDIF
            ENDSCAN
            *======== FIM DO LOOP PRINCIPAL ========

            WAIT CLEAR

            *-- Analisa diferencas Debito x Credito por transacao
            SELECT Transacaos, SUM(VAL(Debs) / 100) AS Deb, SUM(VAL(Creds) / 100) AS Cred ;
                FROM MovAux GROUP BY Transacaos INTO CURSOR Dif1 READWRITE

            SELECT Transacaos FROM Dif1 WHERE Deb <> Cred INTO CURSOR dif2 READWRITE

            SELECT * FROM MovAux ;
                WHERE Transacaos IN (SELECT Transacaos FROM dif2) ;
                INTO CURSOR diferenca READWRITE

            IF RECCOUNT("diferenca") > 0
                THIS.this_lTemDiferencas = .T.
            ENDIF

            *-- Verifica resultado
            SELECT SemConta
            SET ORDER TO Conta
            GO TOP

            IF !EOF()
                THIS.this_lTemInconsistencias = .T.
            ELSE
                SELECT MovAux
                GO TOP
                THIS.this_lTemMovimento = !EOF()
            ENDIF

            IF USED("crSigMvCcr")
                USE IN crSigMvCcr
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            IF USED("crSigMvCcr")
                USE IN crSigMvCcr
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarArquivoContabil - Gera arquivos CTPV*.EMP em DirContabv
    * Retorna .T. se arquivos gerados com sucesso
    *==========================================================================
    PROCEDURE GerarArquivoContabil()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_dDataProc, loc_cEmpProc, loc_cNumAux, loc_cNomeAux
        loc_lSucesso = .F.

        TRY
            IF !USED("MovAux") OR RECCOUNT("MovAux") = 0
                MsgAviso("Nenhum movimento para gerar arquivo.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            SELECT MovAux
            SET ORDER TO EmpCont
            GO TOP

            loc_dDataProc = Datas

            SCAN
                IF (MovAux.Datas <> loc_dDataProc)
                    WAIT WINDOW NOWAIT "Gerando Arquivo Cont" + CHR(225) + "bil : " + EmpCont + " - " + MovAux.Datas
                    loc_dDataProc = Datas
                ENDIF

                loc_cEmpProc = EmpCont
                loc_cNumAux  = SUBSTR(SYS(3), 5)
                loc_cNomeAux = ALLTRIM(THIS.this_cDirContabv) + "CTPV" + loc_cNumAux + "." + ALLTRIM(MovAux.EmpCont)

                IF !FILE(loc_cNomeAux)
                    COPY TO (loc_cNomeAux) WHILE loc_cEmpProc = MovAux.EmpCont TYPE SDF
                    SKIP -1
                ENDIF
            ENDSCAN

            WAIT CLEAR
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega parametros de execucao a partir de cursor
    * Forma OPERACIONAL nao possui tabela persistente. Este metodo aceita um
    * cursor opcional (ex.: cursor de parametros salvos) e restaura os campos
    * de data e configuracao. Se cursor nao existir, retorna .T. sem alterar
    * estado (compativel com fluxo OPERACIONAL de processamento).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        IF PARAMETERS() = 0 OR EMPTY(par_cAliasCursor)
            RETURN .T.
        ENDIF

        IF !USED(par_cAliasCursor)
            RETURN .T.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            IF TYPE(par_cAliasCursor + ".DataI") != "U"
                THIS.this_dDataI = NVL(EVALUATE(par_cAliasCursor + ".DataI"), {})
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataF") != "U"
                THIS.this_dDataF = NVL(EVALUATE(par_cAliasCursor + ".DataF"), {})
            ENDIF
            IF TYPE(par_cAliasCursor + ".DirContabv") != "U"
                THIS.this_cDirContabv = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".DirContabv"), ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".GrupoPags") != "U"
                THIS.this_cGrupoPags = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrupoPags"), ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".GrupoRecs") != "U"
                THIS.this_cGrupoRecs = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrupoRecs"), ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".MoedaCheqs") != "U"
                THIS.this_cMoedaCheqs = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".MoedaCheqs"), ""))
            ENDIF
            IF TYPE(par_cAliasCursor + ".CfgHisICs") != "U"
                THIS.this_nCfgHisICs = NVL(EVALUATE(par_cAliasCursor + ".CfgHisICs"), 0)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros do cursor: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Executa a "insercao" contabil: gera arquivos CTPV*.EMP em disco.
    * Semantica OPERACIONAL: nao ha tabela persistente para INSERT SQL, a
    * operacao de gravacao efetiva do processamento contabil eh a geracao dos
    * arquivos texto. Registra auditoria da operacao.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.GerarArquivoContabil()

            IF loc_lSucesso
                THIS.RegistrarAuditoria("INSERIR")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo cont" + CHR(225) + "bil: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Re-processa o periodo (equivalente a UPDATE em forma OPERACIONAL).
    * Reexecuta o processamento contabil sobre o mesmo periodo carregado,
    * regenerando cursores MovAux/SemConta. Registra auditoria da operacao.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_dDataI) OR EMPTY(THIS.this_dDataF)
            THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + CHR(227) + "o definido. " + ;
                "Informe as datas antes de reprocessar."
            RETURN .F.
        ENDIF

        TRY
            loc_lSucesso = THIS.Processar(THIS.this_dDataI, THIS.this_dDataF)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao reprocessar per" + CHR(237) + "odo: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Registra operacao no log de auditoria (LogAuditoria)
    * Sobrescreve o padrao de BusinessBase para gravar chave descritiva do
    * processamento (periodo processado) em vez de PK de tabela inexistente.
    *==========================================================================
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cQuery, loc_cUsuario, loc_cChave, loc_nRes, loc_oErro

        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cChave = "Periodo: " + DTOC(THIS.this_dDataI) + " a " + DTOC(THIS.this_dDataF)

            loc_cQuery = "INSERT INTO LogAuditoria (Tabela, ChaveRegistro, Operacao, Usuario, DataHora) " + ;
                "VALUES (" + ;
                EscaparSQL("SigPrIct") + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", GETDATE())"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cQuery)

            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Falha ao registrar auditoria."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro em RegistrarAuditoria: " + loc_oErro.Message
        ENDTRY
    ENDPROC

ENDDEFINE
