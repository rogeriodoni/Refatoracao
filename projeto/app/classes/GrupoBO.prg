*==============================================================================
* GrupoBO.prg - Business Object para Grupos de Produto por Operacao
* Tabela principal : SigOpGpo (cgrus, cidchaves, dopes)
* Tabela referencia: SigCdGrp (cgrus, dgrus, mercs)
* Grande Grupo     : SigCdGpr (codigos, descs)
*==============================================================================
DEFINE CLASS GrupoBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "SigOpGpo"
    this_cCampoChave = "cidchaves"

    *-- Codigo da operacao corrente (vem do form pai via crSigCdOpe.Dopes)
    this_cDopes      = ""

    *-- Filtro de grande grupo (SigCdGpr.codigos char(3))
    this_cGdeGrps    = ""

    *-- Flag de gravacao (alteracoes nao salvas no grid)
    this_lGravaDados = .F.

    *-- Nomes dos cursores de trabalho
    this_cCursorOpe      = "cursor_4c_Ope"         && grid de edicao local
    this_cCursorSigOpGpo = "cursor_4c_SigOpGpo"    && cursor persistente (poDataMgr)

    *-- Propriedades para operacoes CRUD unitarias (linha unica de SigOpGpo)
    this_cCgrus      = ""    && SigOpGpo.Cgrus char(3)
    this_cIdChaves   = ""    && SigOpGpo.cIdChaves char(30) (PK gerada por SYS(2015))

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna chave para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDopes
    ENDFUNC

    *==========================================================================
    * InicializarDados - Cria cursor local e carrega dados existentes do SQL Server
    * par_cDopes: codigo da operacao (ex: crSigCdOpe.Dopes do form pai)
    *==========================================================================
    PROCEDURE InicializarDados(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cDopes = ALLTRIM(par_cDopes)

        TRY
            SET NULL ON
            CREATE CURSOR cursor_4c_Ope (Dopes C(20) NULL, Cgrus C(3) NULL, Dgrus C(30) NULL)
            SET NULL OFF
            INDEX ON Cgrus TAG Cgrus
            SET ORDER TO

            IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                SELECT cursor_4c_Ope
                GO TOP
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.Dopes, a.Cgrus, b.Dgrus " + ;
                           "FROM SigOpGpo a " + ;
                           "INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                           "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeTemp") > 0
                    SELECT cursor_4c_Ope
                    ZAP
                    APPEND FROM DBF("cursor_4c_OpeTemp")
                    USE IN cursor_4c_OpeTemp
                ENDIF

                SELECT cursor_4c_Ope
                SET ORDER TO
                GO TOP

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaGrid - Insere linha em branco no cursor local de trabalho
    *==========================================================================
    PROCEDURE InserirLinhaGrid()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ope")
                INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                    VALUES (THIS.this_cDopes, SPACE(3), SPACE(30))
                SELECT cursor_4c_Ope
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InserirLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaGrid - Exclui a linha corrente do cursor local
    *==========================================================================
    PROCEDURE ExcluirLinhaGrid()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                SELECT cursor_4c_Ope
                DELETE
                SKIP
                IF EOF("cursor_4c_Ope")
                    GO BOTTOM
                ENDIF
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExcluirLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Valida Cgrus em SigCdGrp e atualiza Dgrus no cursor local
    * par_cCgrus: codigo digitado
    * RETORNO: .T. se encontrado (Dgrus preenchido), .F. se nao encontrado
    *==========================================================================
    PROCEDURE ValidarGrupo(par_cCgrus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE Cgrus = " + EscaparSQL(ALLTRIM(par_cCgrus))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal") > 0
                IF !EOF("cursor_4c_GrpVal")
                    IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
                        REPLACE Cgrus WITH ALLTRIM(cursor_4c_GrpVal.Cgrus) IN cursor_4c_Ope
                        REPLACE Dgrus WITH ALLTRIM(cursor_4c_GrpVal.Dgrus) IN cursor_4c_Ope
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_GrpVal
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarGrandeGrupo - Carrega grupos de SigCdGrp onde Mercs = par_cGdeGrps
    * par_cGdeGrps: codigo do grande grupo (SigCdGpr.Codigos)
    * RETORNO: .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarGrandeGrupo(par_cGdeGrps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cGdeGrps))
            MsgAviso("Preencha o Grande Grupo Antes de Processar!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cGdeGrps  = par_cGdeGrps
            THIS.this_lGravaDados = .T.

            loc_cSQL = "SELECT Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE Mercs = " + EscaparSQL(ALLTRIM(par_cGdeGrps))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru") < 1
                MsgErro("Falha ao carregar grupos do grande grupo.", "Erro")
            ELSE
                *-- Remover linhas em branco existentes
                IF !EOF("cursor_4c_LocalGru")
                    DELETE FROM cursor_4c_Ope WHERE EMPTY(ALLTRIM(Cgrus))
                ENDIF

                *-- Adicionar grupos ausentes no cursor local
                SELECT cursor_4c_LocalGru
                SCAN
                    SELECT cursor_4c_Ope
                    GO TOP
                    LOCATE FOR ALLTRIM(Cgrus) == ALLTRIM(cursor_4c_LocalGru.Cgrus)
                    IF EOF("cursor_4c_Ope")
                        INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                            VALUES (THIS.this_cDopes, ;
                                    ALLTRIM(cursor_4c_LocalGru.Cgrus), ;
                                    ALLTRIM(cursor_4c_LocalGru.Dgrus))
                    ENDIF
                ENDSCAN

                *-- Linha em branco ao final para entrada manual
                IF !EOF("cursor_4c_LocalGru")
                    INSERT INTO cursor_4c_Ope (Dopes, Cgrus, Dgrus) ;
                        VALUES (THIS.this_cDopes, SPACE(3), SPACE(30))
                ENDIF

                IF USED("cursor_4c_LocalGru")
                    USE IN cursor_4c_LocalGru
                ENDIF

                SELECT cursor_4c_Ope
                GO BOTTOM

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarGrandeGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica grupos duplicados no cursor local
    * RETORNO: .T. se valido (sem duplicatas), .F. se ha duplicatas
    *==========================================================================
    PROTECTED FUNCTION ValidarDuplicidade()
        LOCAL loc_lValido, loc_oErro

        loc_lValido = .T.

        TRY
            SELECT Cgrus, SUM(1) AS nQt ;
                FROM cursor_4c_Ope ;
                WHERE !EMPTY(ALLTRIM(Cgrus)) ;
                GROUP BY Cgrus ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_DupCheck READWRITE

            IF RECCOUNT("cursor_4c_DupCheck") > 0
                MsgAviso("Existem lan" + CHR(231) + "amentos de Grupos Em Duplicidade!!!", ;
                         "Duplicidade")
                loc_lValido = .F.
            ENDIF

            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarDuplicidade")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * Confirmar - Salva todas as alteracoes no SQL Server
    * DELETE + INSERT por operacao (padrao do legado SigOpGpo)
    * RETORNO: .T. se gravado com sucesso, .F. caso contrario
    *==========================================================================
    PROCEDURE Confirmar()
        LOCAL loc_lSucesso, loc_lErroInserir, loc_cSQL, loc_cIdChave, loc_oErro

        loc_lSucesso   = .F.
        loc_lErroInserir = .F.

        TRY
            IF THIS.ValidarDuplicidade()
                loc_cSQL = "DELETE FROM SigOpGpo WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelResult") < 1
                    MsgErro("Erro ao excluir registros anteriores da opera" + CHR(231) + CHR(227) + "o.", "Erro")
                ELSE
                    IF USED("cursor_4c_DelResult")
                        USE IN cursor_4c_DelResult
                    ENDIF

                    SELECT cursor_4c_Ope
                    SCAN FOR !EMPTY(ALLTRIM(Cgrus))
                        loc_cIdChave = SYS(2015)
                        loc_cSQL = "INSERT INTO SigOpGpo (Dopes, Cgrus, cIdChaves) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(THIS.this_cDopes) + ", " + ;
                                   EscaparSQL(ALLTRIM(Cgrus)) + ", " + ;
                                   EscaparSQL(loc_cIdChave) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsResult") < 1
                            MsgErro("Erro ao inserir grupo " + ALLTRIM(Cgrus) + ".", "Erro")
                            loc_lErroInserir = .T.
                            EXIT
                        ENDIF

                        IF USED("cursor_4c_InsResult")
                            USE IN cursor_4c_InsResult
                        ENDIF
                    ENDSCAN

                    IF !loc_lErroInserir
                        THIS.this_lGravaDados = .F.
                        THIS.RegistrarAuditoria("ATUALIZAR")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Confirmar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia colunas de um cursor (crSigCdOpe do form pai ou
    * cursor local do grid) para as propriedades this_c* do BO
    * par_cAliasCursor: nome do cursor origem (default: cursor_4c_Ope)
    * RETORNO: .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(EMPTY(par_cAliasCursor), THIS.this_cCursorOpe, par_cAliasCursor)

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF()
                    *-- Dopes: sempre presente em cursores de operacao/grid
                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        THIS.this_cDopes = ALLTRIM(NVL(Dopes, ""))
                    ENDIF

                    *-- Cgrus: presente no cursor local do grid e em SigOpGpo
                    IF TYPE(loc_cAlias + ".Cgrus") != "U"
                        THIS.this_cCgrus = ALLTRIM(NVL(Cgrus, ""))
                    ENDIF

                    *-- cIdChaves: apenas em SigOpGpo (PK)
                    IF TYPE(loc_cAlias + ".cIdChaves") != "U"
                        THIS.this_cIdChaves = ALLTRIM(NVL(cIdChaves, ""))
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere uma linha unica em SigOpGpo (Dopes, Cgrus, cIdChaves)
    * Usa as propriedades this_cDopes, this_cCgrus preenchidas previamente
    * Gera cIdChaves via SYS(2015) se nao definida
    * RETORNO: .T. se inserido com sucesso, .F. caso contrario
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o (Dopes) n" + CHR(227) + "o informada.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCgrus))
                MsgAviso("Grupo (Cgrus) n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpGpo (Dopes, Cgrus, cIdChaves) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCgrus)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsUnit") < 1
                MsgErro("Erro ao inserir registro em SigOpGpo.", "Erro")
            ELSE
                IF USED("cursor_4c_InsUnit")
                    USE IN cursor_4c_InsUnit
                ENDIF

                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LiberarCursores - Libera todos os cursores temporarios ao fechar
    *==========================================================================
    PROCEDURE LiberarCursores()
        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF
        IF USED("cursor_4c_OpeTemp")
            USE IN cursor_4c_OpeTemp
        ENDIF
        IF USED("cursor_4c_GrpVal")
            USE IN cursor_4c_GrpVal
        ENDIF
        IF USED("cursor_4c_LocalGru")
            USE IN cursor_4c_LocalGru
        ENDIF
        IF USED("cursor_4c_DupCheck")
            USE IN cursor_4c_DupCheck
        ENDIF
        IF USED("cursor_4c_DelResult")
            USE IN cursor_4c_DelResult
        ENDIF
        IF USED("cursor_4c_InsResult")
            USE IN cursor_4c_InsResult
        ENDIF
        IF USED("cursor_4c_InsUnit")
            USE IN cursor_4c_InsUnit
        ENDIF
    ENDPROC

ENDDEFINE
