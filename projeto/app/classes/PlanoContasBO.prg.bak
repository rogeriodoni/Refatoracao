*-- PlanoContasBO.prg
*-- Business Object para Relatorio do Plano de Contas
*--
*-- NOTA: Este NAO eh um BO de CRUD - eh um helper para relatorios
*-- NAO herda de BusinessBase pois nao faz INSERT/UPDATE/DELETE
*--
*-- Data: 2026-02-05
*-- Migrado de: SigRePlc.SCX (frmrelatorio)

DEFINE CLASS PlanoContasBO AS Custom

    *-- Propriedades de filtro
    this_cClasse = ""
    this_cDclasse = ""
    this_nOptCli = 1       && 1=Analitico, 2=Sintetico
    this_nOptFor = 1       && 1=Analitico, 2=Sintetico

    *-- Propriedades internas
    this_cEmpresa = ""
    this_cTitulo = "Plano de Contas"
    this_cMensagemErro = ""

    *-- =============================================
    *-- PROCEDURE Init
    *-- Inicializacao do objeto
    *-- =============================================
    PROCEDURE Init()
        *-- Usar nome da empresa do sistema (populado no login), NUNCA _Screen.Caption
        *-- que retorna "Microsoft Visual FoxPro" em desenvolvimento
        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            THIS.this_cEmpresa = go_4c_Sistema.cEmpresa
        ELSE
            THIS.this_cEmpresa = ""
        ENDIF
        RETURN .T.
    ENDPROC

    *-- =============================================
    *-- PROCEDURE CarregarDadosBase
    *-- Carrega cursores necessarios para o relatorio
    *-- =============================================
    PROCEDURE CarregarDadosBase()
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Carregar parametros do sistema
            loc_cSQL = "SELECT GrPadClis, GrPadFors FROM SigCdPam"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam")
            IF loc_nResultado < 0
                loc_lSucesso = .F.
            ELSE
                *-- Carregar grupos de contas
                loc_cSQL = "SELECT Codigos, Classes, Descrs FROM SigCdGcr"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGcr")
                IF loc_nResultado < 0
                    loc_lSucesso = .F.
                ELSE
                    SELECT crSigCdGcr
                    INDEX ON Classes TAG Classes
                    INDEX ON Codigos TAG Codigos

                    *-- Carregar clientes
                    loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli"
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli")
                    IF loc_nResultado < 0
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdCli
                        *-- Index single-column: SEEK usa apenas Grupos como chave.
                        *-- Composto (Grupos+IClis) quebra com SET EXACT ON porque
                        *-- a chave do SEEK (10 chars) nunca casa exato com a chave do
                        *-- indice (20 chars), fazendo o nivel 5 (clientes) sumir do relatorio.
                        INDEX ON Grupos TAG Grupos

                        *-- Carregar grupos padrao
                        loc_cSQL = "SELECT Coletors, Codigos FROM SigCdGcr WHERE Coletors IN (2, 3)"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crGrpPads")
                        IF loc_nResultado < 0
                            loc_lSucesso = .F.
                        ELSE
                            *-- Carregar plano de contas
                            loc_cSQL = "SELECT a.*, SPACE(10) as cOrd1s FROM SigCdCss a ORDER BY a.Classes"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cTpgc")
                            IF loc_nResultado < 0
                                loc_lSucesso = .F.
                            ELSE
                                SELECT cTpgc
                                INDEX ON Classes TAG Classes
                                INDEX ON TRANSFORM(Nivels, "@L 9") + Classes TAG Nclasses
                                INDEX ON TRANSFORM(Nivels, "@L 9") + Descrs TAG Ndescrs
                                SET ORDER TO Classes IN cTpgc

                                *-- Processar ordem
                                THIS.ProcessarOrdem()
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oExcecao
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- =============================================
    *-- PROCEDURE ProcessarOrdem
    *-- Processa a ordem dos registros
    *-- =============================================
    PROTECTED PROCEDURE ProcessarOrdem()
        LOCAL loc_cGrpCl, loc_nConta1, loc_cOrd1s

        loc_cGrpCl = ""
        loc_nConta1 = 0

        SELECT cTpgc
        SCAN
            IF NOT (PADR(ALLTRIM(cTpgc.Classes), 1) == loc_cGrpCl)
                loc_cGrpCl = PADR(ALLTRIM(cTpgc.Classes), 1)
                loc_nConta1 = 0
            ENDIF

            loc_nConta1 = loc_nConta1 + 1
            loc_cOrd1s = loc_cGrpCl + TRANSFORM(loc_nConta1, "@L 999999999")

            REPLACE cOrd1s WITH loc_cOrd1s
        ENDSCAN
    ENDPROC

    *-- =============================================
    *-- PROCEDURE ValidarClasse
    *-- Valida se a classe eh valida
    *-- =============================================
    PROCEDURE ValidarClasse(par_cClasse)
        LOCAL loc_lValido
        loc_lValido = .T.

        IF NOT EMPTY(par_cClasse)
            IF NOT SEEK("1" + par_cClasse, "cTpgc", "Nclasses")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *-- =============================================
    *-- PROCEDURE ValidarDescricao
    *-- Valida se a descricao eh valida
    *-- =============================================
    PROCEDURE ValidarDescricao(par_cDescricao)
        LOCAL loc_lValido
        loc_lValido = .T.

        IF NOT EMPTY(par_cDescricao)
            IF NOT SEEK("1" + par_cDescricao, "cTpgc", "Ndescrs")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *-- =============================================
    *-- PROCEDURE GerarRelatorio
    *-- Gera o cursor para o relatorio (3 fases: classes raiz, grupos SigCdGcr,
    *-- clientes/fornecedores SigCdCli ? equivalente ao legado SIGREPLC processamento)
    *-- =============================================
    PROCEDURE GerarRelatorio()
        LOCAL loc_cClasse1, loc_cDclasse, loc_nOptCli, loc_nOptFor
        LOCAL loc_cEmpresa, loc_cTitulo1s, loc_cEscape, loc_nDecimals, loc_cFixed
        LOCAL loc_cContas, loc_cDcontas, loc_cOrds, loc_cPs, loc_cIps
        LOCAL loc_nNivels, loc_nConta1, loc_cClasse, loc_nRecNo1, loc_nRecno
        LOCAL loc_cClasse2, loc_cOrd1s, loc_nNivel, loc_nReg
        LOCAL loc_lInb, loc_nCnt, loc_cDes, loc_cLsClasse, loc_cLsGrupo
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        loc_cEscape   = SET("Escape")
        loc_nDecimals = SET("Decimals")
        loc_cFixed    = SET("Fixed")

        loc_cEmpresa = THIS.this_cEmpresa
        loc_cTitulo1s = THIS.this_cTitulo
        loc_cClasse1 = PADR(ALLTRIM(THIS.this_cClasse), 10)
        loc_cDclasse = THIS.this_cDclasse
        loc_nOptCli = THIS.this_nOptCli
        loc_nOptFor = THIS.this_nOptFor

        TRY
            SET ESCAPE OFF
            SET DECIMALS TO 2
            SET FIXED ON

            *-- Fechar cursor anterior se existir
            IF USED("cPlconta")
                USE IN cPlconta
            ENDIF

            *-- Criar cursor de saida
            SET NULL ON
            CREATE CURSOR cPlconta (cEmpresas C(40), cTitulo1s C(80), cContas C(10), ;
                                    cDContas C(50), cOrds C(50), cPs C(1), cIps C(1))
            SET NULL OFF

            LOCAL ARRAY loc_aOrd(15), loc_aStrArea(15)
            loc_aOrd     = ""
            loc_aStrArea = ""
            loc_nRecno   = 0

            *-- ============================================================
            *-- FASE 1: Classes raiz do plano de contas (SigCdCss / cTpgc)
            *-- ============================================================
            SELECT cTpgc
            SET ORDER TO Classes
            GO TOP IN cTpgc

            SCAN
                IF SUBSTR(cTpgc.Classes, 1, 1) = ALLTRIM(THIS.this_cClasse) OR EMPTY(THIS.this_cClasse)
                    loc_cClasse = PADR(ALLTRIM(cTpgc.Classes), 10)
                    loc_nRecNo1 = RECNO("cTpgc")

                    IF NOT EMPTY(loc_cClasse) AND ;
                       SEEK("1" + PADR(PADR(ALLTRIM(loc_cClasse), 1), 10), "cTpgc", "Nclasses") AND ;
                       (EMPTY(loc_cClasse1) OR cTpgc.Classes == loc_cClasse1)

                        IF BETWEEN(loc_nRecNo1, 1, RECCOUNT("cTpgc"))
                            GOTO loc_nRecNo1 IN cTpgc
                        ENDIF

                        loc_cContas = PADR(ALLTRIM(cTpgc.Classes), 10)
                        loc_cDcontas = cTpgc.Descrs
                        loc_nNivels = cTpgc.Nivels
                        loc_cOrds = ""

                        loc_aOrd(loc_nNivels) = SUBSTR(loc_cContas, 1, 10)

                        FOR loc_nConta1 = 1 TO loc_nNivels
                            loc_cOrds = loc_cOrds + loc_aOrd(loc_nConta1)
                        ENDFOR

                        loc_cPs = STR(loc_nNivels, 1)
                        loc_cIps = STR(loc_nNivels, 1)

                        SELECT cPlconta
                        LOCATE FOR cOrds = PADR(loc_cOrds, 50)
                        IF EOF()
                            INSERT INTO cPlconta (cEmpresas, cTitulo1s, cContas, cDcontas, cOrds, cPs, cIps) ;
                                VALUES (loc_cEmpresa, loc_cTitulo1s, loc_cContas, loc_cDcontas, loc_cOrds, loc_cPs, loc_cIps)
                        ENDIF
                    ENDIF

                    GOTO loc_nRecNo1 IN cTpgc
                ENDIF
            ENDSCAN

            *-- ============================================================
            *-- FASE 2+3: Expandir hierarquia ate convergencia
            *-- (grupos SigCdGcr e clientes SigCdCli)
            *-- ============================================================
            SELECT cTpgc
            DO WHILE (loc_nRecno <> RECCOUNT("cPlconta"))
                SELECT cPlconta
                IF (loc_nRecno + 1 > RECCOUNT())
                    EXIT
                ENDIF
                GO loc_nRecno + 1
                loc_nRecno = RECCOUNT()

                *-- Sub-fase 2: Grupos de conta corrente (SigCdGcr) por classe
                DO WHILE (loc_nRecno >= RECNO())
                    loc_cLsClasse = cPlconta.cContas

                    SELECT crSigCdGcr
                    SET ORDER TO Classes
                    IF SEEK(loc_cLsClasse, "crSigCdGcr", "Classes")
                        SCAN WHILE crSigCdGcr.Classes = loc_cLsClasse
                            SELECT cPlconta
                            loc_nNivel   = INT(LEN(ALLTRIM(cPlconta.cOrds)) / 10) + 1
                            loc_cContas  = crSigCdGcr.Codigos
                            loc_cOrds    = SUBSTR(cPlconta.cOrds, 1, 10 * loc_nNivel) + crSigCdGcr.Codigos
                            loc_cDcontas = crSigCdGcr.Descrs
                            loc_cPs      = STR(INT(LEN(ALLTRIM(loc_cOrds)) / 10) + 1, 1)
                            loc_cIps     = STR(INT(LEN(ALLTRIM(loc_cOrds)) / 10) + 1, 1)

                            loc_nReg = RECNO()
                            LOCATE FOR cOrds = PADR(loc_cOrds, 50)
                            IF EOF()
                                GO BOTTOM
                                INSERT INTO cPlconta (cEmpresas, cTitulo1s, cContas, cDcontas, cOrds, cPs, cIps) ;
                                    VALUES (loc_cEmpresa, loc_cTitulo1s, loc_cContas, loc_cDcontas, ;
                                            loc_cOrds, loc_cPs, loc_cIps)
                            ENDIF
                            GO loc_nReg IN cPlconta
                        ENDSCAN
                    ENDIF

                    SELECT cPlconta
                    SKIP
                ENDDO

                *-- Avanca para proximo bloco de registros
                SELECT cPlconta
                IF (loc_nRecno + 1 > RECCOUNT())
                    EXIT
                ENDIF
                GO loc_nRecno + 1
                loc_nRecno = RECCOUNT()

                *-- Sub-fase 3: Clientes (SigCdCli) por grupo
                DO WHILE (loc_nRecno >= RECNO())
                    loc_cLsGrupo = cPlconta.cContas

                    SELECT crSigCdCli
                    SET ORDER TO Grupos
                    IF SEEK(loc_cLsGrupo, "crSigCdCli", "Grupos")
                        loc_lInb = .F.

                        *-- Verificar se e cliente sintetico (excluir grupo padrao)
                        IF (loc_nOptCli = 2)
                            SELECT crSigCdPam
                            GO TOP
                            loc_lInb = (crSigCdCli.Grupos = crSigCdPam.GrPadClis)
                            IF NOT loc_lInb
                                SELECT crGrpPads
                                GO TOP
                                LOCATE FOR Coletors = 2 AND Codigos = crSigCdCli.Grupos
                                IF NOT EOF()
                                    loc_lInb = .T.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Verificar se e fornecedor sintetico (excluir grupo padrao)
                        IF (loc_nOptFor = 2) AND NOT loc_lInb
                            SELECT crSigCdPam
                            GO TOP
                            loc_lInb = (crSigCdCli.Grupos = crSigCdPam.GrPadFors)
                            IF NOT loc_lInb
                                SELECT crGrpPads
                                GO TOP
                                LOCATE FOR Coletors = 3 AND Codigos = crSigCdCli.Grupos
                                IF NOT EOF()
                                    loc_lInb = .T.
                                ENDIF
                            ENDIF
                        ENDIF

                        IF NOT loc_lInb
                            loc_nCnt = 0
                            SELECT crSigCdCli
                            SCAN WHILE crSigCdCli.Grupos = loc_cLsGrupo
                                loc_nCnt = loc_nCnt + 1
                                SELECT cPlconta
                                loc_cDes = ALLTRIM(cPlconta.cContas) + " : " + STR(loc_nCnt, 6)
                                WAIT WINDOW "Processando : " + loc_cDes NOWAIT

                                loc_nNivel   = INT(LEN(ALLTRIM(cPlconta.cOrds)) / 10) + 1
                                loc_aOrd     = ""
                                loc_aStrArea = ""
                                loc_nRecNo1  = RECNO("cTpgc")

                                SELECT crSigCdGcr
                                SET ORDER TO Codigos
                                IF SEEK(crSigCdCli.Grupos, "crSigCdGcr", "Codigos")
                                    IF (NOT EMPTY(crSigCdCli.IClis) AND ;
                                        NOT EMPTY(crSigCdCli.Grupos) AND ;
                                        NOT EOF() AND ;
                                        NOT EMPTY(crSigCdGcr.Classes) AND ;
                                        SEEK("1" + PADR(PADR(ALLTRIM(crSigCdGcr.Classes), 1), 10), "cTpgc", "Nclasses") AND ;
                                        (EMPTY(loc_cClasse1) OR cTpgc.Classes == loc_cClasse1) AND ;
                                        SEEK(crSigCdGcr.Classes, "cTpgc", "Classes"))

                                        loc_cClasse2 = PADR(ALLTRIM(crSigCdGcr.Classes), 10)
                                        loc_cOrd1s   = cTpgc.cOrd1s
                                        loc_nNivels  = cTpgc.Nivels

                                        FOR loc_nConta1 = 1 TO loc_nNivels
                                            loc_aOrd(loc_nConta1)     = PADR(SUBSTR(loc_cClasse2, 1, VAL(SUBSTR("124", loc_nConta1, 1))), 10)
                                            loc_aStrArea(loc_nConta1) = "cTpgc"
                                        ENDFOR

                                        loc_aOrd(loc_nNivels + 1) = PADR(ALLTRIM(crSigCdCli.IClis), 10)
                                        loc_aOrd(loc_nNivels + 2) = PADR(ALLTRIM(crSigCdCli.IClis), 10)

                                        *-- loc_nConta1 = loc_nNivels + 1 apos o FOR
                                        loc_cContas = loc_aOrd(loc_nConta1)

                                        SELECT cPlconta
                                        loc_cOrds    = SUBSTR(cPlconta.cOrds, 1, 10 * loc_nNivel) + crSigCdCli.IClis
                                        loc_cDcontas = crSigCdCli.RClis
                                        loc_cPs      = STR(INT(LEN(ALLTRIM(loc_cOrds)) / 10) + 1, 1)
                                        loc_cIps     = STR(INT(LEN(ALLTRIM(loc_cOrds)) / 10) + 1, 1)

                                        loc_nReg = RECNO()
                                        LOCATE FOR cOrds = PADR(loc_cOrds, 50)
                                        IF EOF()
                                            GO BOTTOM
                                            INSERT INTO cPlconta (cEmpresas, cTitulo1s, cContas, cDcontas, cOrds, cPs, cIps) ;
                                                VALUES (loc_cEmpresa, loc_cTitulo1s, loc_cContas, loc_cDcontas, ;
                                                        loc_cOrds, loc_cPs, loc_cIps)
                                        ENDIF
                                        GO loc_nReg IN cPlconta
                                    ENDIF
                                ENDIF
                                SELECT crSigCdCli
                            ENDSCAN
                            WAIT CLEAR
                        ENDIF
                    ENDIF

                    SELECT cPlconta
                    SKIP
                ENDDO
            ENDDO

            *-- Indexar resultado final por ordem de exibicao
            SELECT cPlconta
            INDEX ON cOrds TAG cOrds
            SET ORDER TO cOrds

            loc_lSucesso = .T.

        CATCH TO loc_oExcecao
            THIS.this_cMensagemErro = loc_oExcecao.Message
            MsgErro(loc_oExcecao.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oExcecao.LineNo), "Erro ao gerar relat" + CHR(243) + "rio")
            loc_lSucesso = .F.
        ENDTRY

        *-- Restaurar configuracoes de ambiente
        IF loc_cEscape = "ON"
            SET ESCAPE ON
        ELSE
            SET ESCAPE OFF
        ENDIF
        SET DECIMALS TO loc_nDecimals
        IF loc_cFixed = "ON"
            SET FIXED ON
        ELSE
            SET FIXED OFF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *-- =============================================
    *-- PROCEDURE LimparCursores
    *-- Fecha cursores temporarios
    *-- =============================================
    PROCEDURE LimparCursores()
        IF USED("cPlConta")
            USE IN cPlConta
        ENDIF
        IF USED("cTmpTpgc")
            USE IN cTmpTpgc
        ENDIF
        IF USED("cTpgc")
            USE IN cTpgc
        ENDIF
        IF USED("crSigCdPam")
            USE IN crSigCdPam
        ENDIF
        IF USED("crSigCdGcr")
            USE IN crSigCdGcr
        ENDIF
        IF USED("crSigCdCli")
            USE IN crSigCdCli
        ENDIF
        IF USED("crGrpPads")
            USE IN crGrpPads
        ENDIF
    ENDPROC

    *-- =============================================
    *-- PROCEDURE Destroy
    *-- Limpa recursos ao destruir
    *-- =============================================
    PROCEDURE Destroy()
        THIS.LimparCursores()
    ENDPROC

ENDDEFINE
