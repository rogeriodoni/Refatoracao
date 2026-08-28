*==============================================================================
* PzoBO.prg - Business Object para Prazo / Conta de Entrega
* Entidade: Pzo (SIGCDPZO - Prazo e Conta de Entrega por Opera??o)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sub-form de movimenta??o)
*
* Contexto: Sub-form modal chamado por formularios de movimento (ex: SigAtCrp).
* Recebe referencia ao form pai com cursores TprMvCab, CrSigCdOpe, CrSigMvNfi,
* crTpmMvItn, TprMvCabG. Edita CsPrazE (prazos/fretes por opera??o) e grava
* de volta em crTpmMvItn ao confirmar.
*==============================================================================

DEFINE CLASS PzoBO AS BusinessBase

    *-- Identificacao da entidade (referencia principal: SigMvCab)
    this_cTabela         = "SigMvCab"
    this_cCampoChave     = "EmpDnCrds"

    *-- Chave composta do pedido (monta EmpDnCrds = Emps + Dopes + STR(Numes,6))
    this_cEmps           = ""
    this_cDopesParent    = ""
    this_nNumesParent    = 0
    this_cEmpDnCrds      = ""

    *-- Modo de operacao do form pai (INSERIR / ALTERAR / VISUALIZAR)
    this_cEscolha        = ""

    *-- Dados do cabecalho do movimento (TprMvCab) necessarios para validacoes
    this_dDatasParent    = {}
    this_nPrazoEnts      = 0
    this_cLocalEntsParent = ""
    this_cContaEsParent  = ""
    this_nCodObsParent   = 0
    this_cObsEsParent    = ""
    this_cContaDs        = ""
    this_cContaOs        = ""
    this_nValVars        = 0

    *-- Dados da linha corrente do cursor CsPrazE (por opera??o/abreviacao)
    *   Estrutura: CsPrazE (Dopes c(20), Abrevs c(3), Prazos T, DtEntrs n(1),
    *              nMinEnts n(3), nMaxEnts n(3), VlFretes n(12,2), nFiscals n(1),
    *              LocalEnts n(10), ContaEs c(10), LocEntObs n(1),
    *              DespAces n(12,2), VlSeguros n(12,2))
    this_cDopes          = ""
    this_cAbrevs         = ""
    this_dPrazos         = {}
    this_nDtEntrs        = 0
    this_nMinEnts        = 0
    this_nMaxEnts        = 0
    this_nVlFretes       = 0
    this_nFiscals        = 0
    this_nLocalEnts      = 0
    this_cContaEs        = ""
    this_nLocEntObs      = 0
    this_nDespAces       = 0
    this_nVlSeguros      = 0

    *-- Dados da opera??o corrente (LocTmpOpe: SigCdOpe + SigOpCdc)
    this_nExibSits       = 0
    this_nChCtEntrs      = 0
    this_nDtEntrsOpe     = 0
    this_nDigObs         = 0

    *-- Dados de validacao de valores minimos (crTodosOpe2: SigOpCdd)
    this_nChkUteis       = 0
    this_nMinFretes      = 0
    this_nMinSeguros     = 0
    this_nMinDesps       = 0

    *-- Conta de entrega (lookup SigCdCli via LocTmpOpe + CsPrazE.ContaEs)
    this_cGetConta       = ""
    this_cGetDConta      = ""
    this_cGetCpf         = ""

    *-- Observa??o da linha (TprMvCabG: CodObs, ObsEs / Obses)
    this_nCodObs         = 0
    this_cObsEs          = ""

    *-- Totalizadores exibidos no rodape do form
    *   FrtTotal / DespTotal / SegTotal vem de CrSigMvNfi (nota fiscal)
    *   FrtInformado / DespInformado / SegInformado sao somados do CsPrazE
    this_nFrtTotal       = 0
    this_nFrtInformado   = 0
    this_nDespTotal      = 0
    this_nDespInformado  = 0
    this_nSegTotal       = 0
    this_nSegInformado   = 0

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDnCrds"

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cEmpDnCrds
    ENDPROC

    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    *-- Carrega this_ a partir da linha corrente do cursor nomeado.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_cAbrevs    = TratarNulo(Abrevs,    "C")
                THIS.this_dPrazos    = IIF(ISNULL(Prazos), DTOT({}), Prazos)
                THIS.this_nDtEntrs   = TratarNulo(DtEntrs,   "N")
                THIS.this_nMinEnts   = TratarNulo(nMinEnts,  "N")
                THIS.this_nMaxEnts   = TratarNulo(nMaxEnts,  "N")
                THIS.this_nVlFretes  = TratarNulo(VlFretes,  "N")
                THIS.this_nFiscals   = TratarNulo(nFiscals,  "N")
                THIS.this_nLocalEnts = TratarNulo(LocalEnts, "N")
                THIS.this_cContaEs   = TratarNulo(ContaEs,   "C")
                THIS.this_nLocEntObs = TratarNulo(LocEntObs, "N")
                THIS.this_nDespAces  = TratarNulo(DespAces,  "N")
                THIS.this_nVlSeguros = TratarNulo(VlSeguros, "N")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION InicializarDados(par_oFormPai)
    *==========================================================================
    *-- Inicializa CsPrazE a partir dos cursores do formulario pai.
    *-- par_oFormPai: referencia ao form pai (ex: Formsigatcrp).
    *-- Pre-requisito: TprMvCab, CrSigCdOpe, CrSigMvNfi, crTpmMvItn abertos.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_nResult, loc_cEmpDopNum
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Conex" + CHR(227) + "o com banco de dados n" + ;
                        CHR(227) + "o estabelecida.", "Erro")
            ELSE
                IF !USED("TprMvCab")
                    MsgErro("Cursor TprMvCab n" + CHR(227) + "o est" + ;
                            CHR(225) + " aberto.", "Erro")
                ELSE
                    IF !USED("CrSigCdOpe")
                        MsgErro("Cursor CrSigCdOpe n" + CHR(227) + "o est" + ;
                                CHR(225) + " aberto.", "Erro")
                    ELSE
                        *-- Armazenar dados do cabecalho do movimento
                        SELECT TprMvCab
                        THIS.this_cEmps            = ALLTRIM(TprMvCab.Emps)
                        THIS.this_cDopesParent     = ALLTRIM(TprMvCab.Dopes)
                        THIS.this_nNumesParent     = TprMvCab.Numes
                        THIS.this_cEmpDnCrds       = ALLTRIM(TprMvCab.Emps) + ;
                                                     ALLTRIM(TprMvCab.Dopes) + ;
                                                     STR(TprMvCab.Numes, 6)
                        THIS.this_dDatasParent     = TprMvCab.Datas
                        THIS.this_cLocalEntsParent = ALLTRIM(TprMvCab.LocalEnts)
                        THIS.this_cContaEsParent   = ALLTRIM(TprMvCab.ContaEs)
                        THIS.this_nCodObsParent    = TprMvCab.CodObs
                        THIS.this_cObsEsParent     = ALLTRIM(TprMvCab.ObsEs)
                        THIS.this_cContaDs         = ALLTRIM(TprMvCab.ContaDs)
                        THIS.this_cContaOs         = ALLTRIM(TprMvCab.ContaOs)
                        THIS.this_nValVars         = NVL(TprMvCab.ValVars, 0)

                        *-- Carregar totais das notas fiscais
                        IF USED("CrSigMvNfi")
                            SELECT CrSigMvNfi
                            THIS.this_nFrtTotal  = NVL(CrSigMvNfi.VlFretes, 0)
                            THIS.this_nDespTotal = NVL(CrSigMvNfi.DespAces, 0)
                            THIS.this_nSegTotal  = NVL(CrSigMvNfi.VlSeguros, 0)
                        ENDIF

                        *-- Query 1: dados anteriores do movimento em SigMvCab
                        loc_cEmpDopNum = THIS.this_cEmpDnCrds
                        loc_cSQL = "SELECT Dopes, PrazoEnts, LocalEnts, ContaEs, " + ;
                                   "CodObs, ObsEs " + ;
                                   "FROM SigMvCab " + ;
                                   "WHERE EmpDnCrds = '" + ALLTRIM(loc_cEmpDopNum) + "'"
                        IF USED("CsPedAnt")
                            USE IN CsPedAnt
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPedAnt")
                        IF loc_nResult < 1
                            MsgErro("Falha ao carregar dados anteriores (CsPedAnt).", "Erro")
                        ELSE
                            SELECT CsPedAnt
                            INDEX ON Dopes TAG Dopes

                            *-- Query 2: operacoes via SigCdMop + SigCdOpe + SigOpCdc
                            IF USED("CsPed")
                                USE IN CsPed
                            ENDIF
                            loc_cSQL = "SELECT a.cDopes, a.cnivels AS Dopes, " + ;
                                       "a.nCors, a.padraos, " + ;
                                       "b.abrevs, b.DtEntrs, b.nFiscals, " + ;
                                       "c.nMinEnts, c.nMaxEnts " + ;
                                       "FROM SigCdMop a, SigCdOpe b, SigOpCdc c " + ;
                                       "WHERE a.cDopes = '" + ALLTRIM(CrSigCdOpe.Dopes) + "' " + ;
                                       "AND a.cnivels = b.dopes " + ;
                                       "AND b.Abrevs <> ' ' AND b.Dopes = c.Dopes"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPed")
                            IF loc_nResult < 1
                                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(245) + ;
                                        "es do pedido (CsPed).", "Erro")
                            ELSE
                                SELECT CsPed
                                INDEX ON nCors  TAG nCors
                                INDEX ON Abrevs TAG Abrevs

                                *-- Query 3: valores minimos por operacao (SigOpCdd)
                                IF USED("crTodosOpe2")
                                    USE IN crTodosOpe2
                                ENDIF
                                loc_cSQL = "SELECT Dopes, chkUteis, MinFretes, " + ;
                                           "MinSeguros, MinDesps FROM SigOpCdd"
                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTodosOpe2")
                                IF loc_nResult < 1
                                    MsgErro("Falha ao carregar valores m" + CHR(237) + ;
                                            "nimos (crTodosOpe2).", "Erro")
                                ELSE
                                    SELECT crTodosOpe2
                                    INDEX ON Dopes TAG Dopes

                                    *-- Query 4: LocEntObs/chkUteis por operacao
                                    IF USED("CsPedOpe2")
                                        USE IN CsPedOpe2
                                    ENDIF
                                    loc_cSQL = "SELECT b.dopes, c.LocEntObs, c.chkUteis " + ;
                                               "FROM SigCdMop a, SigCdOpe b, SigOpCdd c " + ;
                                               "WHERE a.cDopes = '" + ;
                                               ALLTRIM(CrSigCdOpe.Dopes) + "' " + ;
                                               "AND a.cnivels = b.dopes " + ;
                                               "AND b.Abrevs <> ' ' AND b.Dopes = c.Dopes"
                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPedOpe2")
                                    IF loc_nResult < 1
                                        MsgErro("Falha ao carregar dados de opera" + ;
                                                CHR(231) + CHR(227) + "o (CsPedOpe2).", "Erro")
                                    ELSE
                                        SELECT CsPedOpe2
                                        INDEX ON Dopes TAG Dopes

                                        *-- Abreviaturas distintas dos itens do movimento
                                        IF USED("Itens")
                                            USE IN Itens
                                        ENDIF
                                        SELECT DISTINCT AbrevIs FROM crTpmMvItn ;
                                            WHERE Cpros <> ' ' AND Qtds <> 0 ;
                                            INTO CURSOR Itens READWRITE

                                        *-- Montar CsPedidos: CsPed x Itens
                                        IF USED("CsPedidos")
                                            USE IN CsPedidos
                                        ENDIF
                                        SELECT a.*, 0 AS LocEntObs ;
                                            FROM CsPed a, Itens b ;
                                            WHERE a.Abrevs = b.AbrevIs ;
                                            INTO CURSOR CsPedidos READWRITE
                                        SELECT CsPedidos
                                        INDEX ON nCors  TAG nCors
                                        INDEX ON Abrevs TAG Abrevs

                                        *-- Criar CsPrazE
                                        IF USED("CsPrazE")
                                            USE IN CsPrazE
                                        ENDIF
                                        SET NULL ON
                                        CREATE CURSOR CsPrazE ( ;
                                            Dopes     C(20)    NULL, ;
                                            Abrevs    C(3)     NULL, ;
                                            Prazos    T        NULL, ;
                                            DtEntrs   N(1)     NULL, ;
                                            nMinEnts  N(3)     NULL, ;
                                            nMaxEnts  N(3)     NULL, ;
                                            VlFretes  N(12,2)  NULL, ;
                                            nFiscals  N(1)     NULL, ;
                                            LocalEnts N(10)    NULL, ;
                                            ContaEs   C(10)    NULL, ;
                                            LocEntObs N(1)     NULL, ;
                                            DespAces  N(12,2)  NULL, ;
                                            VlSeguros N(12,2)  NULL )
                                        SET NULL OFF

                                        *-- Popular CsPrazE escaneando CsPedidos
                                        SELECT CsPedidos
                                        SCAN
                                            =SEEK(CsPedidos.Dopes, "CsPedOpe2", "Dopes")

                                            INSERT INTO CsPrazE ;
                                                (Dopes, Abrevs, Prazos, DtEntrs, ;
                                                 nMinEnts, nMaxEnts, VlFretes, ;
                                                 nFiscals, LocEntObs) ;
                                                VALUES ( ;
                                                    CsPedidos.Dopes, ;
                                                    CsPedidos.Abrevs, ;
                                                    IIF(EMPTY(TprMvCab.PrazoEnts), ;
                                                        DTOT({}), ;
                                                        TprMvCab.PrazoEnts), ;
                                                    CsPedidos.DtEntrs, ;
                                                    CsPedidos.nMinEnts, ;
                                                    CsPedidos.nMaxEnts, ;
                                                    0, ;
                                                    CsPedidos.nfiscals, ;
                                                    NVL(CsPedOpe2.LocEntObs, 0) )

                                            SELECT CsPedidos

                                            IF INLIST(CsPedidos.DtEntrs, 3, 4, 5, 6)
                                                REPLACE LocalEnts WITH TprMvCab.LocalEnts, ;
                                                        ContaEs   WITH TprMvCab.ContaEs ;
                                                        IN CsPrazE
                                            ENDIF

                                            INSERT INTO TprMvCabG ;
                                                (Dopes, Abrevs, CodObs, ObsEs) ;
                                                VALUES (CsPedidos.Dopes, ;
                                                        CsPedidos.Abrevs, ;
                                                        TprMvCab.CodObs, ;
                                                        TprMvCab.ObsEs)

                                            SELECT CsPedidos

                                            *-- Restaurar prazos/contas do pedido anterior
                                            =SEEK(CsPedidos.Dopes, "CsPedAnt", "Dopes")
                                            IF !EOF("CsPedAnt")
                                                REPLACE Prazos WITH IIF( ;
                                                        EMPTY(TprMvCab.PrazoEnts), ;
                                                        IIF(EMPTY(CsPedAnt.PrazoEnts), ;
                                                            DTOT({}), ;
                                                            CsPedAnt.PrazoEnts), ;
                                                        TprMvCab.PrazoEnts), ;
                                                        LocalEnts WITH CsPedAnt.LocalEnts, ;
                                                        ContaEs   WITH CsPedAnt.ContaEs ;
                                                        IN CsPrazE
                                                REPLACE CodObs WITH CsPedAnt.CodObs, ;
                                                        ObsEs  WITH CsPedAnt.ObsEs ;
                                                        IN TprMvCabG
                                                SELECT CsPedidos
                                            ENDIF
                                        ENDSCAN

                                        SELECT CsPrazE
                                        GO TOP
                                        IF RECCOUNT("CsPrazE") = 0
                                            MsgAviso("N" + CHR(227) + "o h" + ;
                                                     CHR(225) + " opera" + CHR(231) + ;
                                                     CHR(245) + "es de prazo para " + ;
                                                     "este movimento.", "Aviso")
                                        ELSE
                                            THIS.AtualizarTotais()
                                            loc_lSucesso = .T.
                                        ENDIF
                                    ENDIF  && CsPedOpe2
                                ENDIF  && crTodosOpe2
                            ENDIF  && CsPed
                        ENDIF  && CsPedAnt
                    ENDIF  && CrSigCdOpe
                ENDIF  && TprMvCab
            ENDIF  && gnConnHandle

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoLinhaGrid(par_cDopes)
    *==========================================================================
    *-- Carrega dados de SigCdOpe+SigOpCdc para a linha corrente do grid.
    *-- Popula this_nExibSits, this_nChCtEntrs, this_nDtEntrsOpe, this_nDigObs.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Dopes, a.ExibSits, b.ChCtEntrs, b.DtEntrs, b.DigObs " + ;
                       "FROM SigCdOpe a, SigOpCdc b " + ;
                       "WHERE a.Dopes = '" + ALLTRIM(par_cDopes) + "' " + ;
                       "AND a.dopes = b.dopes"
            IF USED("LocTmpOpe")
                USE IN LocTmpOpe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocTmpOpe")
            IF loc_nResult >= 1
                SELECT LocTmpOpe
                GO TOP
                THIS.this_nExibSits   = NVL(LocTmpOpe.ExibSits,  0)
                THIS.this_nChCtEntrs  = NVL(LocTmpOpe.ChCtEntrs, 0)
                THIS.this_nDtEntrsOpe = NVL(LocTmpOpe.DtEntrs,   0)
                THIS.this_nDigObs     = NVL(LocTmpOpe.DigObs,    0)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Confirmar()
    *==========================================================================
    *-- Valida todos os prazos e atualiza crTpmMvItn com os dados de CsPrazE.
    *-- Retorna .T. se confirmado com sucesso.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_lcMsg, loc_ldDat, loc_ldEnt, loc_tEmpty
        loc_lSucesso = .F.
        loc_tEmpty   = DTOT({})

        TRY
            IF !USED("CsPrazE")
                MsgErro("Cursor CsPrazE n" + CHR(227) + "o est" + CHR(225) + ;
                        " aberto.", "Erro")
            ELSE
                IF !USED("crTpmMvItn")
                    MsgErro("Cursor crTpmMvItn n" + CHR(227) + "o est" + ;
                            CHR(225) + " aberto.", "Erro")
                ELSE
                    *-- Limpar campos de entrega antes de regravar
                    UPDATE crTpmMvItn ;
                        SET PrzEnts   = m.loc_tEmpty, ;
                            ValFrts   = 0, ;
                            LocalEnts = 0, ;
                            ValSegs   = 0, ;
                            ContaEs   = "", ;
                            DespAces  = 0

                    loc_lSucesso = .T.

                    *-- Escanear CsPrazE validando e atualizando crTpmMvItn
                    SELECT CsPrazE
                    SCAN WHILE loc_lSucesso
                        *-- Validar prazo de entrega se operacao exige data
                        IF INLIST(CsPrazE.DtEntrs, 1, 4, 6)
                            IF EMPTY(CsPrazE.Prazos)
                                MsgAviso("Prazo de Entrega da Opera" + CHR(231) + ;
                                         CHR(227) + "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                         " deve ser informado...", ;
                                         "Obrigat" + CHR(243) + "rio")
                                loc_lSucesso = .F.
                            ENDIF

                            IF loc_lSucesso
                                loc_ldDat = TTOD(CsPrazE.Prazos)
                                IF loc_ldDat < THIS.this_dDatasParent
                                    MsgAviso("Prazo de Entrega da Opera" + ;
                                             CHR(231) + CHR(227) + "o " + ;
                                             ALLTRIM(CsPrazE.Dopes) + ;
                                             " deve ser maior que a Data da " + ;
                                             "Movimenta" + CHR(231) + CHR(227) + "o...", ;
                                             "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND CsPrazE.nMinEnts > 0
                                loc_ldEnt = THIS.this_dDatasParent + CsPrazE.nMinEnts
                                IF TTOD(CsPrazE.Prazos) < loc_ldEnt
                                    MsgAviso("Prazo de Entrega M" + CHR(237) + ;
                                             "nimo da Opera" + CHR(231) + CHR(227) + ;
                                             "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                             " " + CHR(233) + " " + DTOC(loc_ldEnt) + ;
                                             "...", "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND CsPrazE.nMaxEnts > 0
                                loc_ldEnt = THIS.this_dDatasParent + CsPrazE.nMaxEnts
                                IF TTOD(CsPrazE.Prazos) > loc_ldEnt
                                    MsgAviso("Prazo de Entrega M" + CHR(225) + ;
                                             "ximo da Opera" + CHR(231) + CHR(227) + ;
                                             "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                             " " + CHR(233) + " " + DTOC(loc_ldEnt) + ;
                                             "...", "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Validar local de entrega obrigatorio
                        IF loc_lSucesso AND CsPrazE.LocEntObs = 1 AND ;
                           INLIST(CsPrazE.DtEntrs, 3, 4, 5, 6) AND ;
                           CsPrazE.LocalEnts = 0
                            MsgAviso("Local de Entrega da Opera" + CHR(231) + ;
                                     CHR(227) + "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                     " n" + CHR(227) + "o Informado!!!", ;
                                     "Obrigat" + CHR(243) + "rio")
                            loc_lSucesso = .F.
                        ENDIF

                        *-- Validar valores minimos (Frete / Desp. Acessorias)
                        IF loc_lSucesso AND USED("crTodosOpe2")
                            =SEEK(CsPrazE.Dopes, "crTodosOpe2", "Dopes")
                            loc_lcMsg = ""
                            IF !EOF("crTodosOpe2")
                                IF !EMPTY(crTodosOpe2.MinFretes) AND ;
                                   (CsPrazE.VlFretes < crTodosOpe2.MinFretes)
                                    loc_lcMsg = loc_lcMsg + ;
                                                IIF(EMPTY(loc_lcMsg), "", " / ") + ;
                                                "Frete"
                                ENDIF
                                IF !EMPTY(crTodosOpe2.MinDesps) AND ;
                                   (CsPrazE.DespAces < crTodosOpe2.MinDesps)
                                    loc_lcMsg = loc_lcMsg + ;
                                                IIF(EMPTY(loc_lcMsg), "", " / ") + ;
                                                "Desp. Acess" + CHR(243) + "rias"
                                ENDIF
                                IF !EMPTY(loc_lcMsg)
                                    MsgAviso("Existem Valores Na Opera" + CHR(231) + ;
                                             CHR(227) + "o Abaixo do M" + CHR(237) + ;
                                             "nimo : " + loc_lcMsg, "ERRO")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF
                            SELECT CsPrazE
                        ENDIF

                        *-- Atualizar crTpmMvItn com dados validados
                        IF loc_lSucesso
                            UPDATE crTpmMvItn SET ;
                                PrzEnts   = CsPrazE.Prazos, ;
                                ValFrts   = CsPrazE.VlFretes, ;
                                LocalEnts = CsPrazE.LocalEnts, ;
                                ValSegs   = CsPrazE.VlSeguros, ;
                                ContaEs   = CsPrazE.ContaEs, ;
                                DespAces  = CsPrazE.DespAces ;
                                WHERE ALLTRIM(AbrevIs) = ALLTRIM(CsPrazE.Abrevs)
                            SELECT CsPrazE
                        ENDIF
                    ENDSCAN

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("ATUALIZAR")
                    ENDIF
                ENDIF  && crTpmMvItn
            ENDIF  && CsPrazE

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Confirmar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarTotais()
    *==========================================================================
    *-- Recalcula this_nFrtInformado/this_nDespInformado/this_nSegInformado.
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF USED("CsPrazE")
                SELECT SUM(NVL(VlFretes, 0))  AS TotFrt, ;
                       SUM(NVL(DespAces, 0))  AS TotDesp, ;
                       SUM(NVL(VlSeguros, 0)) AS TotSeg ;
                    FROM CsPrazE ;
                    INTO CURSOR cursor_4c_TotaisPzo READWRITE
                IF USED("cursor_4c_TotaisPzo")
                    SELECT cursor_4c_TotaisPzo
                    GO TOP
                    THIS.this_nFrtInformado  = NVL(TotFrt,  0)
                    THIS.this_nDespInformado = NVL(TotDesp, 0)
                    THIS.this_nSegInformado  = NVL(TotSeg,  0)
                    USE IN cursor_4c_TotaisPzo
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.AtualizarTotais")
        ENDTRY
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoConta(par_cConta, par_nChCtEntrs)
    *==========================================================================
    *-- Carrega dados de cliente (conta de entrega) de SigCdCli.
    *-- Popula this_cGetConta, this_cGetDConta, this_cGetCpf.
    *-- Retorna .T. se encontrou e passou nas validacoes.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cConta)
                THIS.this_cGetConta  = ""
                THIS.this_cGetDConta = ""
                THIS.this_cGetCpf    = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT IClis, RClis, Cpfs FROM SigCdCli " + ;
                           "WHERE IClis = '" + ALLTRIM(par_cConta) + "'"
                IF USED("CrTmpCli")
                    USE IN CrTmpCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpCli")
                IF loc_nResult < 1
                    MsgErro("Falha ao carregar dados do cliente.", "Erro")
                ELSE
                    SELECT CrTmpCli
                    GO TOP
                    IF !EOF("CrTmpCli")
                        *-- Validar conta de entrega (nao pode ser igual a destino/origem)
                        IF par_nChCtEntrs = 1 AND ;
                           ALLTRIM(CrTmpCli.IClis) == ALLTRIM(THIS.this_cContaDs)
                            MsgAviso("Conta de Entrega Tem que ser diferente da " + ;
                                     "Conta de Destino", ;
                                     "Valida" + CHR(231) + CHR(227) + "o")
                        ELSE
                            IF par_nChCtEntrs = 2 AND ;
                               ALLTRIM(CrTmpCli.IClis) == ALLTRIM(THIS.this_cContaOs)
                                MsgAviso("Conta de Entrega Tem que ser diferente da " + ;
                                         "Conta de Origem", ;
                                         "Valida" + CHR(231) + CHR(227) + "o")
                            ELSE
                                THIS.this_cGetConta  = ALLTRIM(CrTmpCli.IClis)
                                THIS.this_cGetDConta = ALLTRIM(CrTmpCli.RClis)
                                THIS.this_cGetCpf    = ALLTRIM(CrTmpCli.Cpfs)
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("CrTmpCli")
                        USE IN CrTmpCli
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoConta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoObservacao(par_nCodObs, par_cDopesOpe)
    *==========================================================================
    *-- Busca observacao de SigCdObs filtrando pela faixa da operacao.
    *-- Popula this_nCodObs e this_cObsEs. Retorna .T. se encontrou.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        LOCAL loc_nIni, loc_nFim
        loc_lSucesso = .F.

        TRY
            *-- Buscar faixa de observacoes da operacao
            loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
                       "WHERE Dopes = '" + ALLTRIM(par_cDopesOpe) + "'"
            IF USED("LocalOpe")
                USE IN LocalOpe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalOpe")
            IF loc_nResult < 1
                MsgErro("Falha ao carregar dados da opera" + CHR(231) + ;
                        CHR(227) + "o.", "Erro")
            ELSE
                SELECT LocalOpe
                GO TOP
                loc_nIni = IIF(!EOF("LocalOpe") AND !EMPTY(LocalOpe.ObsInis), ;
                               LocalOpe.ObsInis, 0)
                loc_nFim = IIF(!EOF("LocalOpe") AND !EMPTY(LocalOpe.ObsFins), ;
                               LocalOpe.ObsFins, 999)
                IF USED("LocalOpe")
                    USE IN LocalOpe
                ENDIF

                *-- Carregar observacoes na faixa da operacao
                loc_cSQL = "SELECT Codigos, Descrs, Observas FROM SigCdObs " + ;
                           "WHERE Codigos BETWEEN " + TRANSFORM(loc_nIni) + ;
                           " AND " + TRANSFORM(loc_nFim)
                IF USED("crLocalObs")
                    USE IN crLocalObs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalObs")
                IF loc_nResult < 1
                    MsgErro("Falha ao carregar observa" + CHR(231) + CHR(245) + ;
                            "es (crLocalObs).", "Erro")
                ELSE
                    SELECT crLocalObs
                    INDEX ON Codigos TAG Codigos

                    IF SEEK(par_nCodObs, "crLocalObs", "Codigos")
                        THIS.this_nCodObs = NVL(crLocalObs.Codigos, 0)
                        THIS.this_cObsEs  = ALLTRIM(NVL(crLocalObs.Observas, ""))
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoObservacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Inserir()
    *==========================================================================
    *-- Operacional: registra auditoria de insercao se CsPrazE inicializado.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("CsPrazE n" + CHR(227) + "o inicializado. " + ;
                        "Chamar InicializarDados() antes de Inserir().", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Atualizar()
    *==========================================================================
    *-- Operacional: delega para Confirmar() que valida e salva CsPrazE.
    *==========================================================================
        RETURN THIS.Confirmar()
    ENDPROC

    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
    *==========================================================================
        LOCAL loc_oErro, loc_cSQL
        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND ;
               !EMPTY(THIS.this_cEmpDnCrds) AND !EMPTY(gc_4c_UsuarioLogado)
                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                           "(DataHora, Usuario, Operacao, Tabela, " + ;
                           "ChaveRegistro) " + ;
                           "VALUES (" + ;
                           "GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL("SigMvCab") + ", " + ;
                           EscaparSQL(THIS.this_cEmpDnCrds) + ")"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE
