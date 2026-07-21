*==============================================================================
* ALEBO.PRG
* Business Object para Configuracao de Alertas por Conta (SigCdAle)
*
* Tabela Principal : SigCdAle - Alertas configurados por conta/operacao
*                    (pkchaves C(20) PK, dopes C, Tabelas C, inserirs N, alterars N,
*                     excluirs N, baixas N, priors N, mensagems text, datas T, dtalts T,
*                     contas C, grupos C, usuarios C)
*
* Logica: Form OPERACIONAL que configura quais alertas uma conta recebe
*         para cada tabela de referencia (SIGCDOPE/SIGCDGCR/SIGCDPRO/SIGCDOPD/SIGOPOPE).
*         Confirmar = DELETE todos os alertas da conta + re-INSERT apenas registros com
*         pelo menos um flag ativo (inserirs<>0 OR alterars<>0 OR excluirs<>0 OR baixas<>0).
*         O grid exibe uniao das 5 tabelas de referencia com LEFT JOIN em SigCdAle.
*==============================================================================

DEFINE CLASS aleBO AS BusinessBase

    *-- Identificacao da conta (parametro recebido pelo form)
    this_cContas              = ""    && IClis da conta selecionada (FK SigCdCli)

    *-- Campos da SigCdAle (registro atual)
    this_cDopes               = ""    && Codigo da operacao/grupo/produto (FK variavel)
    this_cTabelas             = ""    && Tabela de referencia (SIGCDOPE/SIGCDGCR/SIGCDPRO/SIGCDOPD/SIGOPOPE)
    this_nInserirs            = 0     && Flag permissao Inserir (0=nao, 1=sim)
    this_nAlterars            = 0     && Flag permissao Alterar (0=nao, 1=sim)
    this_nExcluirs            = 0     && Flag permissao Excluir (0=nao, 1=sim)
    this_nBaixas              = 0     && Flag permissao Baixar  (0=nao, 1=sim)
    this_nPriors              = 0     && Prioridade numerica (0=NORMAL, 1=URGENTE, 2=IMPORTANTE)
    this_cMensagems           = ""    && Mensagem de alerta (varchar/text)
    this_dDatas               = {}    && Data/hora de criacao
    this_dDtalts              = {}    && Data/hora de ultima alteracao
    this_cGrupos              = ""    && Grupo associado
    this_cPkChaves            = ""    && Chave primaria unica gerada por fUniqueIds()
    this_cUsuarios            = ""    && Usuario que realizou a configuracao

    *-- Descricao para exibicao (coluna Descrs do cursor, nao persiste em SigCdAle)
    this_cDescrs              = ""    && Descricao derivada da tabela de referencia

    *-- Modo de operacao herdado do form pai (INSERIR/ALTERAR)
    this_cPcEscolha           = ""    && Modo vindo de parentform.pcescolha

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdAle"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados de uma linha do cursor crSigCdAle
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes      = TratarNulo(Dopes,     "C")
                THIS.this_cDescrs     = TratarNulo(Descrs,    "C")
                THIS.this_cTabelas    = TratarNulo(Tabelas,   "C")
                THIS.this_nInserirs   = NVL(inserirs,  0)
                THIS.this_nAlterars   = NVL(alterars,  0)
                THIS.this_nExcluirs   = NVL(excluirs,  0)
                THIS.this_nBaixas     = NVL(baixas,    0)
                THIS.this_nPriors     = NVL(priors,    0)
                THIS.this_cMensagems  = TratarNulo(mensagems, "C")
                THIS.this_cGrupos     = TratarNulo(grupos,    "C")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,  "C")
                THIS.this_cContas     = TratarNulo(contas,    "C")
                THIS.this_cUsuarios   = TratarNulo(usuarios,  "C")

                IF VARTYPE(datas) = "T" OR VARTYPE(datas) = "D"
                    THIS.this_dDatas  = NVL(datas,  {})
                ELSE
                    THIS.this_dDatas  = {}
                ENDIF

                IF VARTYPE(dtalts) = "T" OR VARTYPE(dtalts) = "D"
                    THIS.this_dDtalts = NVL(dtalts, {})
                ELSE
                    THIS.this_dDtalts = {}
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para estado vazio
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cDopes      = ""
        THIS.this_cDescrs     = ""
        THIS.this_cTabelas    = ""
        THIS.this_nInserirs   = 0
        THIS.this_nAlterars   = 0
        THIS.this_nExcluirs   = 0
        THIS.this_nBaixas     = 0
        THIS.this_nPriors     = 0
        THIS.this_cMensagems  = ""
        THIS.this_cGrupos     = ""
        THIS.this_cPkChaves   = ""
        THIS.this_cUsuarios   = ""
        THIS.this_dDatas      = {}
        THIS.this_dDtalts     = {}
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertas - Popula os 5 cursores de referencia com LEFT JOIN SigCdAle
    * e une em crSigCdAle com INDEX ON Tabelas TAG Tabelas
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAlertas(par_cContas)
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_cContasEsc
        loc_lResultado = .F.
        THIS.this_cContas = ALLTRIM(NVL(par_cContas, ""))

        TRY
            loc_cContasEsc = EscaparSQL(THIS.this_cContas)

            *-- Movimentacao de Estoque (SigCdOpe)
            loc_cSQL = "SELECT OPE.dopes, OPE.Dopes AS Descrs, 'SIGCDOPE' AS Tabelas, " + ;
                "CASE WHEN ALE.inserirs IS NULL THEN 0 ELSE ALE.inserirs END inserirs, " + ;
                "CASE WHEN ALE.alterars IS NULL THEN 0 ELSE ALE.alterars END alterars, " + ;
                "CASE WHEN ALE.excluirs IS NULL THEN 0 ELSE ALE.excluirs END excluirs, " + ;
                "CASE WHEN ALE.baixas IS NULL THEN 0 ELSE ALE.baixas END baixas, " + ;
                "CASE WHEN ALE.priors = 1 THEN 'URGENTE' WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN ALE.mensagems IS NULL THEN '' ELSE ALE.mensagems END mensagems, " + ;
                "ALE.datas, ALE.dtalts, ALE.contas, " + ;
                "CASE WHEN ALE.grupos IS NULL THEN '' ELSE ALE.grupos END grupos, " + ;
                "CASE WHEN ALE.pkchaves IS NULL THEN '' ELSE ALE.pkchaves END pkchaves, " + ;
                "CASE WHEN ALE.priors IS NULL THEN 0 ELSE ALE.priors END priors, " + ;
                "CASE WHEN ALE.usuarios IS NULL THEN '' ELSE ALE.usuarios END usuarios " + ;
                "FROM SigCdOpe OPE " + ;
                "INNER JOIN SigOpCdc CDC ON CDC.Dopes = OPE.Dopes AND CDC.OpeInatvs = 0 " + ;
                "LEFT OUTER JOIN SigCdAle ALE ON OPE.Dopes = ALE.dopes " + ;
                "AND ALE.Tabelas = 'SIGCDOPE' AND ALE.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpe")

            *-- Grupo de Contas (SigCdGcr)
            loc_cSQL = "SELECT a.Codigos AS Dopes, a.Descrs, 'SIGCDGCR' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdGcr a " + ;
                "LEFT OUTER JOIN SigCdAle b ON SUBSTRING(b.Dopes, 1, 10) = a.Codigos " + ;
                "AND b.Tabelas = 'SIGCDGCR' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleGcr")

            *-- Grupo de Produtos (SigCdGrp -> SIGCDPRO)
            loc_cSQL = "SELECT a.Cgrus AS Dopes, a.Dgrus AS Descrs, 'SIGCDPRO' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdGrp a " + ;
                "LEFT OUTER JOIN SigCdAle b ON SUBSTRING(b.Dopes, 1, 3) = a.Cgrus " + ;
                "AND b.Tabelas = 'SIGCDPRO' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AlePro")

            *-- Movimentacao de Producao (SigCdOpd -> SIGCDOPD)
            loc_cSQL = "SELECT a.Dopps AS Dopes, a.Dopps AS Descrs, 'SIGCDOPD' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigCdOpd a " + ;
                "LEFT OUTER JOIN SigCdAle b ON b.Dopes = a.Dopps " + ;
                "AND b.Tabelas = 'SIGCDOPD' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpd")

            *-- Movimentacao Financeira (SigOpOpe -> SIGOPOPE)
            loc_cSQL = "SELECT a.Dopes AS Dopes, a.Dopes AS Descrs, 'SIGOPOPE' AS Tabelas, " + ;
                "CASE WHEN b.inserirs IS NULL THEN 0 ELSE b.inserirs END inserirs, " + ;
                "CASE WHEN b.alterars IS NULL THEN 0 ELSE b.alterars END alterars, " + ;
                "CASE WHEN b.excluirs IS NULL THEN 0 ELSE b.excluirs END excluirs, " + ;
                "CASE WHEN b.baixas IS NULL THEN 0 ELSE b.baixas END baixas, " + ;
                "CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                "ELSE 'NORMAL' END prioridade, " + ;
                "CASE WHEN b.mensagems IS NULL THEN '' ELSE b.mensagems END mensagems, " + ;
                "b.datas, b.dtalts, b.contas, " + ;
                "CASE WHEN b.grupos IS NULL THEN '' ELSE b.grupos END grupos, " + ;
                "CASE WHEN b.pkchaves IS NULL THEN '' ELSE b.pkchaves END pkchaves, " + ;
                "CASE WHEN b.priors IS NULL THEN 0 ELSE b.priors END priors, " + ;
                "CASE WHEN b.usuarios IS NULL THEN '' ELSE b.usuarios END usuarios " + ;
                "FROM SigOpOpe a " + ;
                "LEFT OUTER JOIN SigCdAle b ON b.Dopes = a.Dopes " + ;
                "AND b.Tabelas = 'SIGOPOPE' AND b.contas = " + loc_cContasEsc
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AleOpOpe")

            *-- Unir os 5 cursores em crSigCdAle com estrutura identica
            IF USED("crSigCdAle")
                TABLEREVERT(.T., "crSigCdAle")
                USE IN crSigCdAle
            ENDIF

            SET NULL ON
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpe ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(RTRIM(Dopes) + " - " + RTRIM(Descrs), 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleGcr ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(RTRIM(Dopes) + " - " + RTRIM(Descrs), 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AlePro ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpd ;
            UNION ALL ;
            SELECT ;
                Dopes, PADR(Descrs, 60) AS Descrs, Tabelas, ;
                inserirs, alterars, excluirs, baixas, prioridade, ;
                CAST(mensagems AS CHAR(200)) AS Mensagems, ;
                datas, dtalts, contas, grupos, pkchaves, priors, usuarios ;
                FROM cursor_4c_AleOpOpe ;
            INTO CURSOR crSigCdAle READWRITE ORDER BY Tabelas, Dopes
            SET NULL OFF

            SELECT crSigCdAle
            INDEX ON Tabelas TAG Tabelas
            SET ORDER TO TAG Tabelas
            SET KEY TO "SIGCDOPE"
            GO TOP

            *-- Fechar cursores intermediarios
            IF USED("cursor_4c_AleOpe")
                USE IN cursor_4c_AleOpe
            ENDIF
            IF USED("cursor_4c_AleGcr")
                USE IN cursor_4c_AleGcr
            ENDIF
            IF USED("cursor_4c_AlePro")
                USE IN cursor_4c_AlePro
            ENDIF
            IF USED("cursor_4c_AleOpd")
                USE IN cursor_4c_AleOpd
            ENDIF
            IF USED("cursor_4c_AleOpOpe")
                USE IN cursor_4c_AleOpOpe
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar alertas")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlertas - Salva configuracao de alertas da conta:
    *   1. Filtra crSigCdAle para registros com ao menos 1 flag ativo
    *   2. DELETE todos os alertas da conta no SQL Server
    *   3. Re-INSERT cada registro filtrado (INSERT direto via SQLEXEC)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlertas(par_cPcEscolha)
        LOCAL loc_lResultado, loc_oErro, loc_cSQL
        LOCAL loc_cDopes, loc_cTabelas, loc_nInserirs, loc_nAlterars
        LOCAL loc_nExcluirs, loc_nBaixas, loc_nPriors, loc_cMensagems
        LOCAL loc_cGrupos, loc_cPkChaves, loc_cUsuarios
        LOCAL loc_dDatas, loc_cContasEsc, loc_cPcEscolha
        loc_lResultado = .F.
        loc_cPcEscolha = UPPER(ALLTRIM(NVL(par_cPcEscolha, "")))

        TRY
            IF !USED("crSigCdAle")
                THIS.this_cMensagemErro = "Cursor de alertas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                MsgAviso(THIS.this_cMensagemErro, "Aviso")
            ELSE
                loc_cContasEsc = EscaparSQL(THIS.this_cContas)

                *-- Seleciona apenas registros com pelo menos um flag ativo
                SELECT Dopes, Tabelas, inserirs, alterars, excluirs, baixas, ;
                       prioridade, CAST(Mensagems AS CHAR(200)) AS Mensagems, ;
                       datas, dtalts, grupos, pkchaves, priors, usuarios ;
                    FROM crSigCdAle ;
                    WHERE inserirs <> 0 OR alterars <> 0 OR excluirs <> 0 OR baixas <> 0 ;
                    INTO CURSOR cursor_4c_AleSave READWRITE

                SELECT cursor_4c_AleSave
                GO TOP

                *-- DELETE todos os alertas existentes desta conta
                loc_cSQL = "DELETE FROM SigCdAle WHERE Contas = " + loc_cContasEsc
                SQLEXEC(gnConnHandle, loc_cSQL)

                *-- Re-INSERT cada registro ativo
                LOCAL loc_lErroInsert
                loc_lErroInsert = .F.
                SCAN
                    loc_cDopes     = ALLTRIM(NVL(Dopes,    ""))
                    loc_cTabelas   = ALLTRIM(NVL(Tabelas,  ""))
                    loc_nInserirs  = NVL(inserirs, 0)
                    loc_nAlterars  = NVL(alterars, 0)
                    loc_nExcluirs  = NVL(excluirs, 0)
                    loc_nBaixas    = NVL(baixas,   0)
                    loc_nPriors    = NVL(priors,   0)
                    loc_cMensagems = ALLTRIM(NVL(Mensagems, ""))
                    loc_cGrupos    = ALLTRIM(NVL(grupos,   ""))
                    loc_cUsuarios  = gc_4c_UsuarioLogado
                    loc_cPkChaves  = fUniqueIds()

                    IF loc_cPcEscolha = "INSERIR"
                        loc_dDatas    = GETDATE()
                        loc_cSQL = "INSERT INTO SigCdAle " + ;
                            "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                            "priors, mensagems, datas, contas, grupos, pkchaves, usuarios) " + ;
                            "VALUES (" + ;
                            EscaparSQL(loc_cDopes)     + ", " + ;
                            EscaparSQL(loc_cTabelas)   + ", " + ;
                            FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                            FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                            FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                            EscaparSQL(loc_cMensagems) + ", " + ;
                            "GETDATE(), "               + ;
                            EscaparSQL(THIS.this_cContas) + ", " + ;
                            EscaparSQL(loc_cGrupos)    + ", " + ;
                            EscaparSQL(loc_cPkChaves)  + ", " + ;
                            EscaparSQL(loc_cUsuarios)  + ")"
                    ELSE
                        *-- ALTERAR: preserva datas original se existir, gera dtalts
                        IF VARTYPE(datas) = "T" AND !EMPTY(datas)
                            loc_cSQL = "INSERT INTO SigCdAle " + ;
                                "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                                "priors, mensagems, datas, dtalts, contas, grupos, pkchaves, usuarios) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cDopes)     + ", " + ;
                                EscaparSQL(loc_cTabelas)   + ", " + ;
                                FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                                FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                                EscaparSQL(loc_cMensagems) + ", " + ;
                                FormatarDataSQL(datas)     + ", " + ;
                                "GETDATE(), "               + ;
                                EscaparSQL(THIS.this_cContas) + ", " + ;
                                EscaparSQL(loc_cGrupos)    + ", " + ;
                                EscaparSQL(loc_cPkChaves)  + ", " + ;
                                EscaparSQL(loc_cUsuarios)  + ")"
                        ELSE
                            loc_cSQL = "INSERT INTO SigCdAle " + ;
                                "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                                "priors, mensagems, datas, dtalts, contas, grupos, pkchaves, usuarios) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cDopes)     + ", " + ;
                                EscaparSQL(loc_cTabelas)   + ", " + ;
                                FormatarNumeroSQL(loc_nInserirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nAlterars, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nExcluirs, 0) + ", " + ;
                                FormatarNumeroSQL(loc_nBaixas,   0) + ", " + ;
                                FormatarNumeroSQL(loc_nPriors,   0) + ", " + ;
                                EscaparSQL(loc_cMensagems) + ", " + ;
                                "GETDATE(), "               + ;
                                "GETDATE(), "               + ;
                                EscaparSQL(THIS.this_cContas) + ", " + ;
                                EscaparSQL(loc_cGrupos)    + ", " + ;
                                EscaparSQL(loc_cPkChaves)  + ", " + ;
                                EscaparSQL(loc_cUsuarios)  + ")"
                        ENDIF
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        THIS.this_cMensagemErro = "Erro ao inserir alerta para " + loc_cDopes
                        MsgErro(THIS.this_cMensagemErro, "Erro ao salvar")
                        loc_lErroInsert = .T.
                        EXIT
                    ELSE
                        *-- Registra auditoria de cada linha inserida no batch
                        THIS.this_cPkChaves = loc_cPkChaves
                        THIS.RegistrarAuditoria(IIF(loc_cPcEscolha = "INSERIR", "INSERT", "UPDATE"))
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_AleSave")
                    USE IN cursor_4c_AleSave
                ENDIF

                IF !loc_lErroInsert
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao salvar alertas")
            IF USED("cursor_4c_AleSave")
                USE IN cursor_4c_AleSave
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro em SigCdAle
    * Usa as propriedades this_* previamente populadas (via FormParaBO ou setter)
    * Gera pkchaves via fUniqueIds(), datas via GETDATE()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cContas)
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o informada"
            ELSE
                IF EMPTY(THIS.this_cDopes)
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado"
                ELSE
                    IF EMPTY(THIS.this_cTabelas)
                        THIS.this_cMensagemErro = "Tabela de refer" + CHR(234) + "ncia n" + CHR(227) + "o informada"
                    ELSE
                        THIS.this_cPkChaves = fUniqueIds()
                        THIS.this_cUsuarios = gc_4c_UsuarioLogado

                        loc_cSQL = "INSERT INTO SigCdAle " + ;
                            "(dopes, Tabelas, inserirs, alterars, excluirs, baixas, " + ;
                            "priors, mensagems, datas, contas, grupos, pkchaves, usuarios) " + ;
                            "VALUES (" + ;
                            EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cTabelas))   + ", " + ;
                            FormatarNumeroSQL(THIS.this_nInserirs, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nAlterars, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nExcluirs, 0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nBaixas,   0) + ", " + ;
                            FormatarNumeroSQL(THIS.this_nPriors,   0) + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cMensagems)) + ", " + ;
                            "GETDATE(), " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cContas))    + ", " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cGrupos))    + ", " + ;
                            EscaparSQL(THIS.this_cPkChaves)           + ", " + ;
                            EscaparSQL(THIS.this_cUsuarios)           + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nRet < 0
                            THIS.this_cMensagemErro = "Falha ao inserir alerta no SQL Server"
                        ELSE
                            THIS.RegistrarAuditoria("INSERT")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorTabela - Aplica SET KEY TO na tabela de referencia selecionada
    * par_nOpcao: 1=SIGCDOPE, 2=SIGCDGCR, 3=SIGCDOPD, 4=SIGCDPRO, 5=SIGOPOPE
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarPorTabela(par_nOpcao)
        LOCAL loc_cChave, loc_oErro
        DO CASE
            CASE par_nOpcao = 1
                loc_cChave = "SIGCDOPE"
            CASE par_nOpcao = 2
                loc_cChave = "SIGCDGCR"
            CASE par_nOpcao = 3
                loc_cChave = "SIGCDOPD"
            CASE par_nOpcao = 4
                loc_cChave = "SIGCDPRO"
            OTHERWISE
                loc_cChave = "SIGOPOPE"
        ENDCASE

        TRY
            IF USED("crSigCdAle")
                SELECT crSigCdAle
                SET ORDER TO TAG Tabelas
                SET KEY TO loc_cChave
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
