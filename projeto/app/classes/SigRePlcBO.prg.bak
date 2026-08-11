*==============================================================================
* SIGREPLCBO.PRG
* Business Object para Relatorio do Plano de Contas
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS SigRePlcBO AS RelatorioBase

    *-- Propriedades da tabela
    this_cTabela          = "SigCdCss"
    this_cCampoChave      = "Classes"
    this_cMensagemErro    = ""

    *-- Propriedades de filtro (populadas pelo form via FormParaRelatorio)
    this_cClasse          = ""
    this_cDclasse         = ""
    this_nOptCli          = 1
    this_nOptFor          = 1

    *-- Estado interno
    this_lDadosCarregados = .F.

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDados
    * Carrega cursores auxiliares necessarios para validacao e processamento:
    *   cursor_4c_SigCdPam  - parametros padrao (grupos cli/for)
    *   cursor_4c_SigCdGcr  - grupos de conta corrente (com indices)
    *   cursor_4c_SigCdCli  - clientes (com indice Grupos)
    *   cursor_4c_GrpPads   - grupos padrao (coletores 2=cli, 3=for)
    *   cursor_4c_Tpgc      - plano de contas (SigCdCss) com cOrd1s calculado
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_lcQuery, loc_lcGrpCl, loc_lnConta1, loc_cOrd1s
        loc_lSucesso = .T.
        TRY
            *-- 1. SigCdPam: parametros padrao de grupos de clientes e fornecedores
            loc_lcQuery = "SELECT GrPadClis, GrPadFors FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_SigCdPam") <= 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPam"
                loc_lSucesso = .F.
            ENDIF

            *-- 2. SigCdGcr: grupos de conta corrente
            IF loc_lSucesso
                loc_lcQuery = "SELECT Codigos, Classes, Descrs FROM SigCdGcr"
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_SigCdGcr") <= 0
                    THIS.this_cMensagemErro = "Erro ao carregar SigCdGcr"
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
            IF loc_lSucesso
                SELECT cursor_4c_SigCdGcr
                INDEX ON Classes TAG Classes
                INDEX ON Codigos TAG Codigos
            ENDIF

            *-- 3. SigCdCli: clientes
            IF loc_lSucesso
                loc_lcQuery = "SELECT Grupos, IClis, RClis FROM SigCdCli"
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_SigCdCli") <= 0
                    THIS.this_cMensagemErro = "Erro ao carregar SigCdCli"
                    loc_lSucesso = .F.
                ENDIF
            ENDIF
            IF loc_lSucesso
                SELECT cursor_4c_SigCdCli
                *-- Index single-column: SEEK usa apenas Grupos como chave.
                *-- Composto (Grupos+IClis) quebra com SET EXACT ON porque
                *-- a chave do SEEK (10 chars) nunca casa exato com a chave do
                *-- indice (20 chars), fazendo o nivel 5 (clientes) sumir do relatorio.
                INDEX ON Grupos TAG Grupos
            ENDIF

            *-- 4. GrpPads: subconjunto de SigCdGcr (coletores padrao 2=cli, 3=for)
            IF loc_lSucesso
                loc_lcQuery = "SELECT Coletors, Codigos FROM SigCdGcr WHERE Coletors IN (2, 3)"
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_GrpPads") <= 0
                    THIS.this_cMensagemErro = "Erro ao carregar GrpPads"
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- 5. SigCdCss: plano de contas - carrega em cursor gravavel com campo cOrd1s
            IF loc_lSucesso
                loc_lcQuery = "SELECT Classes, Descrs, Nivels FROM SigCdCss ORDER BY Classes"
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_TpgcTemp") <= 0
                    THIS.this_cMensagemErro = "Erro ao carregar SigCdCss"
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                *-- Criar cursor gravavel com campo calculado cOrd1s
                SET NULL ON
                CREATE CURSOR cursor_4c_Tpgc ;
                    (Classes C(10), Descrs C(50), Nivels N(3), cOrd1s C(10))
                SET NULL OFF
                SELECT cursor_4c_TpgcTemp
                SCAN
                    INSERT INTO cursor_4c_Tpgc (Classes, Descrs, Nivels, cOrd1s) ;
                        VALUES (cursor_4c_TpgcTemp.Classes, cursor_4c_TpgcTemp.Descrs, ;
                                cursor_4c_TpgcTemp.Nivels, SPACE(10))
                ENDSCAN
                IF USED("cursor_4c_TpgcTemp")
                    USE IN cursor_4c_TpgcTemp
                ENDIF

                *-- Criar indices necessarios
                SELECT cursor_4c_Tpgc
                INDEX ON Classes TAG Classes
                INDEX ON TRANSFORM(Nivels, "@L 9") + Classes TAG Nclasses
                INDEX ON TRANSFORM(Nivels, "@L 9") + Descrs  TAG Ndescrs
                SET ORDER TO Classes IN cursor_4c_Tpgc

                *-- Calcular cOrd1s: prefixo do grupo (1 char) + sequencial (9 chars)
                loc_lcGrpCl  = ""
                loc_lnConta1 = 0
                SELECT cursor_4c_Tpgc
                GO TOP
                SCAN
                    IF NOT (PADR(ALLTRIM(cursor_4c_Tpgc.Classes), 1) == loc_lcGrpCl)
                        loc_lcGrpCl  = PADR(ALLTRIM(cursor_4c_Tpgc.Classes), 1)
                        loc_lnConta1 = 0
                    ENDIF
                    loc_lnConta1 = loc_lnConta1 + 1
                    loc_cOrd1s   = loc_lcGrpCl + TRANSFORM(loc_lnConta1, "@L 999999999")
                    REPLACE cOrd1s WITH loc_cOrd1s
                ENDSCAN

                THIS.this_lDadosCarregados = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados
    * Monta cursor cursor_4c_PlConta com hierarquia completa do plano de contas.
    * Equivalente ao metodo "processamento" do form legado SIGREPLC.
    * Requer: cursor_4c_Tpgc, cursor_4c_SigCdGcr, cursor_4c_SigCdCli,
    *         cursor_4c_SigCdPam, cursor_4c_GrpPads (abertos por InicializarDados)
    * Usa filtros: this_cClasse, this_nOptCli, this_nOptFor
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_lcEmpresa, loc_lcTitulo1s, loc_lcClasse1, loc_lcEscape, loc_lnDecimals, loc_lcFixed
        LOCAL loc_lnOptCli, loc_lnOptFor
        LOCAL loc_cContas, loc_cDcontas, loc_cOrds, loc_cPs, loc_cIps
        LOCAL loc_lcClasse, loc_lnRecNo1, loc_lnNivels, loc_lnConta1, loc_lcOrds
        LOCAL loc_lcClasse2, loc_lcOrd1s, loc_lnNivel, loc_lnRecno
        LOCAL loc_llInb, loc_lnCnt, loc_lcDes, loc_lsClasse, loc_lsGrupo, loc_lnReg

        loc_lSucesso   = .T.
        loc_lcEscape   = SET("Escape")
        loc_lnDecimals = SET("Decimals")
        loc_lcFixed    = SET("Fixed")

        TRY
            SET ESCAPE OFF
            SET DECIMALS TO 2
            SET FIXED ON

            loc_lcEmpresa  = go_4c_Sistema.cEmpresa
            loc_lcTitulo1s = "Plano de Contas"
            loc_lcClasse1  = PADR(ALLTRIM(THIS.this_cClasse), 10)
            loc_lnOptCli   = THIS.this_nOptCli
            loc_lnOptFor   = THIS.this_nOptFor

            *-- Fechar cursor anterior se existir
            IF USED("cursor_4c_PlConta")
                USE IN cursor_4c_PlConta
            ENDIF

            *-- Criar cursor resultado
            SET NULL ON
            CREATE CURSOR cursor_4c_PlConta ;
                (cEmpresas C(40), cTitulo1s C(80), cContas C(10), cDcontas C(50), ;
                 cOrds C(50), cPs C(1), cIps C(1))
            SET NULL OFF

            LOCAL ARRAY loc_laOrd(15), loc_laStrArea(15)
            loc_laOrd     = ""
            loc_laStrArea = ""
            loc_lnRecno   = 0

            *-- ================================================================
            *-- FASE 1: Processar classes iniciais (SigCdCss nivel raiz)
            *-- ================================================================
            SELECT cursor_4c_Tpgc
            SET ORDER TO Classes
            GO TOP IN cursor_4c_Tpgc
            SCAN
                IF (SUBSTR(cursor_4c_Tpgc.Classes, 1, 1) = ALLTRIM(THIS.this_cClasse))
                    loc_lcClasse = PADR(ALLTRIM(cursor_4c_Tpgc.Classes), 10)
                    loc_lnRecNo1 = RECNO("cursor_4c_Tpgc")

                    IF (NOT EMPTY(loc_lcClasse) AND ;
                        SEEK("1" + PADR(PADR(ALLTRIM(loc_lcClasse), 1), 10), "cursor_4c_Tpgc", "Nclasses") AND ;
                        (EMPTY(loc_lcClasse1) OR cursor_4c_Tpgc.Classes == loc_lcClasse1))

                        IF BETWEEN(loc_lnRecNo1, 1, RECCOUNT("cursor_4c_Tpgc"))
                            GO loc_lnRecNo1 IN cursor_4c_Tpgc
                        ENDIF

                        loc_cContas  = PADR(ALLTRIM(cursor_4c_Tpgc.Classes), 10)
                        loc_cDcontas = cursor_4c_Tpgc.Descrs
                        loc_lnNivels = cursor_4c_Tpgc.Nivels
                        loc_cOrds    = ""

                        loc_laOrd(loc_lnNivels) = SUBSTR(loc_cContas, 1, 10)
                        FOR loc_lnConta1 = 1 TO loc_lnNivels
                            loc_cOrds = loc_cOrds + loc_laOrd(loc_lnConta1)
                        ENDFOR

                        loc_cPs    = STR(loc_lnNivels, 1)
                        loc_cIps   = STR(loc_lnNivels, 1)
                        loc_lcOrds = loc_cOrds

                        SELECT cursor_4c_PlConta
                        LOCATE FOR cOrds = PADR(loc_cOrds, 50)
                        IF EOF()
                            INSERT INTO cursor_4c_PlConta (cEmpresas, cTitulo1s, cContas, cDcontas, cOrds, cPs, cIps) ;
                                VALUES (loc_lcEmpresa, loc_lcTitulo1s, loc_cContas, loc_cDcontas, ;
                                        loc_cOrds, loc_cPs, loc_cIps)
                        ENDIF
                    ENDIF
                    GO loc_lnRecNo1 IN cursor_4c_Tpgc
                ENDIF
            ENDSCAN

            *-- ================================================================
            *-- FASE 2+3: Expandir hierarquia ate convergencia (sem novos registros)
            *-- ================================================================
            SELECT cursor_4c_Tpgc
            DO WHILE (loc_lnRecno <> RECCOUNT())
                SELECT cursor_4c_PlConta
                IF (loc_lnRecno + 1 > RECCOUNT())
                    EXIT
                ENDIF
                GO loc_lnRecno + 1
                loc_lnRecno = RECCOUNT()

                *-- Sub-fase 2: Grupos de conta corrente (SigCdGcr) por classe
                DO WHILE (loc_lnRecno >= RECNO())
                    loc_lsClasse = cursor_4c_PlConta.cContas

                    SELECT cursor_4c_SigCdGcr
                    SET ORDER TO Classes
                    IF SEEK(loc_lsClasse, "cursor_4c_SigCdGcr", "Classes")
                        SCAN WHILE cursor_4c_SigCdGcr.Classes = loc_lsClasse
                            SELECT cursor_4c_PlConta
                            loc_lnNivel  = INT(LEN(ALLTRIM(cursor_4c_PlConta.cOrds)) / 10) + 1
                            loc_cContas  = cursor_4c_SigCdGcr.Codigos
                            loc_cOrds    = SUBSTR(cursor_4c_PlConta.cOrds, 1, 10 * loc_lnNivel) + cursor_4c_SigCdGcr.Codigos
                            loc_cDcontas = cursor_4c_SigCdGcr.Descrs
                            loc_cPs      = STR(INT(LEN(ALLTRIM(loc_cOrds)) / 10) + 1, 1)
                            loc_cIps     = STR(INT(LEN(ALLTRIM(loc_cOrds)) / 10) + 1, 1)

                            loc_lnReg = RECNO()
                            LOCATE FOR cOrds = PADR(loc_cOrds, 50)
                            IF EOF()
                                GO BOTTOM
                                INSERT INTO cursor_4c_PlConta (cEmpresas, cTitulo1s, cContas, cDcontas, cOrds, cPs, cIps) ;
                                    VALUES (loc_lcEmpresa, loc_lcTitulo1s, loc_cContas, loc_cDcontas, ;
                                            loc_cOrds, loc_cPs, loc_cIps)
                            ENDIF
                            GO loc_lnReg IN cursor_4c_PlConta
                        ENDSCAN
                    ENDIF

                    SELECT cursor_4c_PlConta
                    SKIP
                ENDDO

                *-- Avanca para proximo bloco de registros
                SELECT cursor_4c_PlConta
                IF (loc_lnRecno + 1 > RECCOUNT())
                    EXIT
                ENDIF
                GO loc_lnRecno + 1
                loc_lnRecno = RECCOUNT()

                *-- Sub-fase 3: Clientes (SigCdCli) por grupo
                DO WHILE (loc_lnRecno >= RECNO())
                    loc_lsGrupo = cursor_4c_PlConta.cContas

                    SELECT cursor_4c_SigCdCli
                    SET ORDER TO Grupos
                    IF SEEK(loc_lsGrupo, "cursor_4c_SigCdCli", "Grupos")
                        loc_llInb = .F.

                        *-- Verificar se e cliente sintetico (excluir grupo padrao)
                        IF (loc_lnOptCli = 2)
                            SELECT cursor_4c_SigCdPam
                            GO TOP
                            loc_llInb = (cursor_4c_SigCdCli.Grupos = cursor_4c_SigCdPam.GrPadClis)
                            IF NOT loc_llInb
                                SELECT cursor_4c_GrpPads
                                GO TOP
                                LOCATE FOR Coletors = 2 AND Codigos = cursor_4c_SigCdCli.Grupos
                                IF NOT EOF()
                                    loc_llInb = .T.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Verificar se e fornecedor sintetico (excluir grupo padrao)
                        IF (loc_lnOptFor = 2) AND NOT loc_llInb
                            SELECT cursor_4c_SigCdPam
                            GO TOP
                            loc_llInb = (cursor_4c_SigCdCli.Grupos = cursor_4c_SigCdPam.GrPadFors)
                            IF NOT loc_llInb
                                SELECT cursor_4c_GrpPads
                                GO TOP
                                LOCATE FOR Coletors = 3 AND Codigos = cursor_4c_SigCdCli.Grupos
                                IF NOT EOF()
                                    loc_llInb = .T.
                                ENDIF
                            ENDIF
                        ENDIF

                        IF NOT loc_llInb
                            loc_lnCnt = 0
                            SELECT cursor_4c_SigCdCli
                            SCAN WHILE cursor_4c_SigCdCli.Grupos = loc_lsGrupo
                                loc_lnCnt = loc_lnCnt + 1
                                SELECT cursor_4c_PlConta
                                loc_lcDes = ALLTRIM(cursor_4c_PlConta.cContas) + " : " + STR(loc_lnCnt, 6)
                                WAIT WINDOW "Processando : " + loc_lcDes NOWAIT

                                loc_lnNivel   = INT(LEN(ALLTRIM(cursor_4c_PlConta.cOrds)) / 10) + 1
                                loc_laOrd     = ""
                                loc_laStrArea = ""
                                loc_lnRecNo1  = RECNO("cursor_4c_Tpgc")

                                SELECT cursor_4c_SigCdGcr
                                SET ORDER TO Codigos
                                IF SEEK(cursor_4c_SigCdCli.Grupos, "cursor_4c_SigCdGcr", "Codigos")
                                    IF (NOT EMPTY(cursor_4c_SigCdCli.IClis) AND ;
                                        NOT EMPTY(cursor_4c_SigCdCli.Grupos) AND ;
                                        NOT EOF() AND ;
                                        NOT EMPTY(cursor_4c_SigCdGcr.Classes) AND ;
                                        SEEK("1" + PADR(PADR(ALLTRIM(cursor_4c_SigCdGcr.Classes), 1), 10), "cursor_4c_Tpgc", "Nclasses") AND ;
                                        (EMPTY(loc_lcClasse1) OR cursor_4c_Tpgc.Classes == loc_lcClasse1) AND ;
                                        SEEK(cursor_4c_SigCdGcr.Classes, "cursor_4c_Tpgc", "Classes"))

                                        loc_lcClasse2 = PADR(ALLTRIM(cursor_4c_SigCdGcr.Classes), 10)
                                        loc_lcOrd1s   = cursor_4c_Tpgc.cOrd1s
                                        loc_lnNivels  = cursor_4c_Tpgc.Nivels

                                        FOR loc_lnConta1 = 1 TO loc_lnNivels
                                            loc_laOrd(loc_lnConta1)     = PADR(SUBSTR(loc_lcClasse2, 1, VAL(SUBSTR("124", loc_lnConta1, 1))), 10)
                                            loc_laStrArea(loc_lnConta1) = "cursor_4c_Tpgc"
                                        ENDFOR

                                        loc_laOrd(loc_lnNivels + 1) = PADR(ALLTRIM(cursor_4c_SigCdCli.IClis), 10)
                                        loc_laOrd(loc_lnNivels + 2) = PADR(ALLTRIM(cursor_4c_SigCdCli.IClis), 10)

                                        *-- loc_lnConta1 = loc_lnNivels + 1 apos o FOR
                                        loc_cContas = loc_laOrd(loc_lnConta1)

                                        SELECT cursor_4c_PlConta
                                        loc_cOrds    = SUBSTR(cursor_4c_PlConta.cOrds, 1, 10 * loc_lnNivel) + cursor_4c_SigCdCli.IClis
                                        loc_cDcontas = cursor_4c_SigCdCli.RClis
                                        loc_cPs      = STR(INT(LEN(ALLTRIM(loc_cOrds)) / 10) + 1, 1)
                                        loc_cIps     = STR(INT(LEN(ALLTRIM(loc_cOrds)) / 10) + 1, 1)

                                        loc_lnReg = RECNO()
                                        LOCATE FOR cOrds = PADR(loc_cOrds, 50)
                                        IF EOF()
                                            GO BOTTOM
                                            INSERT INTO cursor_4c_PlConta (cEmpresas, cTitulo1s, cContas, cDcontas, cOrds, cPs, cIps) ;
                                                VALUES (loc_lcEmpresa, loc_lcTitulo1s, loc_cContas, loc_cDcontas, ;
                                                        loc_cOrds, loc_cPs, loc_cIps)
                                        ENDIF
                                        GO loc_lnReg IN cursor_4c_PlConta
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_SigCdCli
                            ENDSCAN
                            WAIT CLEAR
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_PlConta
                    SKIP
                ENDDO
            ENDDO

            *-- Indexar resultado final por ordem de exibicao
            SELECT cursor_4c_PlConta
            INDEX ON cOrds TAG cOrds
            SET ORDER TO cOrds

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        *-- Restaurar configuracoes do ambiente
        IF loc_lcEscape = "ON"
            SET ESCAPE ON
        ELSE
            SET ESCAPE OFF
        ENDIF
        SET DECIMALS TO loc_lnDecimals
        IF loc_lcFixed = "ON"
            SET FIXED ON
        ELSE
            SET FIXED OFF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos por InicializarDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF
        IF USED("cursor_4c_SigCdGcr")
            USE IN cursor_4c_SigCdGcr
        ENDIF
        IF USED("cursor_4c_SigCdCli")
            USE IN cursor_4c_SigCdCli
        ENDIF
        IF USED("cursor_4c_GrpPads")
            USE IN cursor_4c_GrpPads
        ENDIF
        IF USED("cursor_4c_Tpgc")
            USE IN cursor_4c_Tpgc
        ENDIF
        IF USED("cursor_4c_PlConta")
            USE IN cursor_4c_PlConta
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
