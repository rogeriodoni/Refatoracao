*==============================================================================
* Gr1BO.prg - Business Object: Geracao de Grupos de Acesso
* Tabela principal: SigCdGrA (grupos)
* Tabelas auxiliares: SigCdAcU (acessos por usuario), SigCdAcB (acessos do grupo)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS Gr1BO AS BusinessBase

    this_cTabela          = "SigCdGrA"
    this_cCampoChave      = "Grupos"

    *-- Dados do usuario selecionado (SigCdUsu)
    this_cUsuarios        = ""
    this_cNComps          = ""

    *-- Dados do novo grupo a criar (SigCdGrA)
    this_cGrupos          = ""
    this_cGrupoNComps     = ""

    *-- Cursores de trabalho
    this_cCursorAcessos   = "cursor_4c_Acessos"
    this_cCursorBarra     = "cursor_4c_Barra"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdGrA"
        THIS.this_cCampoChave = "Grupos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos      = TratarNulo(Grupos, "C")
            THIS.this_cGrupoNComps = TratarNulo(nComps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de gravar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cGrupos))
            MsgAviso("Informe o c" + CHR(243) + "digo do grupo.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cGrupoNComps))
            MsgAviso("Informe o nome do grupo.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "INSERT INTO SigCdGrA (Grupos, nComps) VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupoNComps)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir grupo no banco de dados.", ;
                            "Erro de Inser" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigCdGrA SET nComps = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupoNComps)) + ;
                           " WHERE Grupos = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupos))

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("U")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar grupo no banco de dados.", ;
                            "Erro de Atualiza" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove registro de SigCdGrA
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGrA WHERE Grupos = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("D")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupo.", ;
                        "Erro de Exclus" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarAcessosPorUsuario - Carrega cursor_4c_Acessos para o grid
    * Equivale ao Valid de GetCodigo/GetDescri no legado
    *--------------------------------------------------------------------------
    FUNCTION BuscarAcessosPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuarios
        LOCAL loc_cProgram, loc_cParam, loc_cDescricao

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorAcessos)
                USE IN (THIS.this_cCursorAcessos)
            ENDIF
            IF USED("cursor_4c_AcessosTemp")
                USE IN cursor_4c_AcessosTemp
            ENDIF
            IF USED("cursor_4c_PrgDesc")
                USE IN cursor_4c_PrgDesc
            ENDIF

            loc_cUsuarios = EscaparSQL(ALLTRIM(par_cUsuarios))

            *-- Acessos diretos do usuario + via grupos aos quais pertence
            loc_cSQL = "SELECT DISTINCT a.Programas, a.Parametros, " + ;
                       "CAST('' AS VARCHAR(150)) AS Descricaos " + ;
                       "FROM SigCdAcU a " + ;
                       "LEFT OUTER JOIN SigCdAcG b ON a.Grupos = b.Grupos " + ;
                       "WHERE NOT a.Programas = SPACE(10) AND " + ;
                       "(a.Usuarios = " + loc_cUsuarios + ;
                       " OR b.Usuarios = " + loc_cUsuarios + ") " + ;
                       "ORDER BY a.Programas, a.Parametros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcessosTemp") > 0

                SET NULL ON
                CREATE CURSOR cursor_4c_Acessos ;
                    (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
                SET NULL OFF

                SELECT cursor_4c_AcessosTemp
                SCAN
                    loc_cProgram   = ALLTRIM(cursor_4c_AcessosTemp.Programas)
                    loc_cParam     = ALLTRIM(cursor_4c_AcessosTemp.Parametros)
                    loc_cDescricao = loc_cProgram + " / " + loc_cParam

                    loc_cSQL = "SELECT descricaos FROM SigCdPrg " + ;
                               "WHERE programas = " + EscaparSQL(loc_cProgram) + ;
                               " AND Parametros = " + EscaparSQL(loc_cParam)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrgDesc") > 0
                        IF !EOF("cursor_4c_PrgDesc")
                            loc_cDescricao = ALLTRIM(cursor_4c_PrgDesc.descricaos)
                        ENDIF
                        IF USED("cursor_4c_PrgDesc")
                            USE IN cursor_4c_PrgDesc
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Acessos
                    INSERT INTO cursor_4c_Acessos VALUES ;
                        (cursor_4c_AcessosTemp.Programas, ;
                         cursor_4c_AcessosTemp.Parametros, ;
                         loc_cDescricao)
                ENDSCAN

                IF USED("cursor_4c_AcessosTemp")
                    USE IN cursor_4c_AcessosTemp
                ENDIF

                SELECT cursor_4c_Acessos
                GO TOP

                *-- Carrega tambem barras para uso no SalvarGrupo
                THIS.CarregarBarrasDoUsuario(par_cUsuarios)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarAcessosPorUsuario")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarBarrasDoUsuario - Carrega cursor_4c_Barra (dados para SigCdAcB)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarBarrasDoUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuarios

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorBarra)
                USE IN (THIS.this_cCursorBarra)
            ENDIF

            loc_cUsuarios = EscaparSQL(ALLTRIM(par_cUsuarios))

            loc_cSQL = "SELECT a.grupos, a.usuarios, a.descricaos, a.barraforms, " + ;
                       "a.barraordem, a.programas, a.parametros, a.selbarras " + ;
                       "FROM SigCdAcB a " + ;
                       "LEFT JOIN SigCdPrg b " + ;
                       "ON b.programas + b.parametros = a.programas + a.parametros " + ;
                       "WHERE a.usuarios = " + loc_cUsuarios + ;
                       " UNION ALL " + ;
                       "SELECT a.grupos, a.usuarios, a.descricaos, a.barraforms, " + ;
                       "a.barraordem, a.programas, a.parametros, a.selbarras " + ;
                       "FROM SigCdAcB a " + ;
                       "LEFT JOIN SigCdPrg b " + ;
                       "ON b.programas + b.parametros = a.programas + a.parametros " + ;
                       "WHERE a.grupos IN " + ;
                       "(SELECT c.grupos FROM SigCdAcG c WHERE c.usuarios = " + loc_cUsuarios + ") " + ;
                       "ORDER BY 1, 2"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Barra") > 0
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarBarrasDoUsuario")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGrupoExistente - Verifica se codigo de grupo ja existe em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION ValidarGrupoExistente(par_cGrupo)
        LOCAL loc_lExiste, loc_oErro, loc_cSQL

        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT Grupos FROM SigCdGrA " + ;
                       "WHERE Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpCheck") > 0
                loc_lExiste = !EOF("cursor_4c_GrpCheck")
                IF USED("cursor_4c_GrpCheck")
                    USE IN cursor_4c_GrpCheck
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarGrupoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * RemoverAcessoLocal - Remove registro corrente do cursor_4c_Acessos (local)
    *--------------------------------------------------------------------------
    FUNCTION RemoverAcessoLocal()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorAcessos) AND !EOF(THIS.this_cCursorAcessos)
                SELECT (THIS.this_cCursorAcessos)
                DELETE
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RemoverAcessoLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupo - Cria novo grupo copiando acessos do usuario
    * Orquestra INSERT em SigCdGrA, SigCdAcU e SigCdAcB via transacao
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupo(par_cUsuarios, par_cGrupo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cGrupo, loc_cPkChave
        LOCAL loc_lTransacaoAberta, loc_lErroBanco

        loc_lSucesso        = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroBanco      = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cUsuarios))
                MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(ALLTRIM(par_cGrupo))
                MsgAviso("Grupo inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cGrupo = EscaparSQL(ALLTRIM(par_cGrupo))

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacaoAberta = .T.

                *-- 1. Insere o novo grupo em SigCdGrA
                loc_cSQL = "INSERT INTO SigCdGrA (Grupos, nComps) VALUES (" + ;
                           loc_cGrupo + ", " + loc_cGrupo + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                    loc_lErroBanco = .T.
                ENDIF

                *-- 2. Para cada acesso nao-deletado em cursor_4c_Acessos,
                *--    insere em SigCdAcU associado ao novo grupo
                IF !loc_lErroBanco AND USED(THIS.this_cCursorAcessos)
                    SELECT (THIS.this_cCursorAcessos)
                    SCAN FOR !DELETED() AND !loc_lErroBanco
                        loc_cPkChave = EscaparSQL(SYS(2015) + SYS(2015))
                        loc_cSQL = "INSERT INTO SigCdAcU " + ;
                                   "(pkChaves, Programas, Parametros, Grupos, Usuarios) " + ;
                                   "VALUES (" + ;
                                   loc_cPkChave + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Acessos.Programas)) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Acessos.Parametros)) + ", " + ;
                                   loc_cGrupo + ", '')"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            loc_lErroBanco = .T.
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- 3. Para cada barra em cursor_4c_Barra,
                *--    insere em SigCdAcB com grupo=NovoGrupo e usuario=vazio
                IF !loc_lErroBanco AND USED(THIS.this_cCursorBarra)
                    SELECT (THIS.this_cCursorBarra)
                    SCAN FOR !loc_lErroBanco
                        loc_cPkChave = EscaparSQL(SYS(2015) + SYS(2015))
                        loc_cSQL = "INSERT INTO SigCdAcB " + ;
                                   "(pkChaves, grupos, usuarios, descricaos, " + ;
                                   "barraforms, barraordem, programas, parametros, selbarras) " + ;
                                   "VALUES (" + ;
                                   loc_cPkChave + ", " + ;
                                   loc_cGrupo + ", " + ;
                                   "'', " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.descricaos, "")), 73)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.barraforms, "")), 50)) + ", " + ;
                                   FormatarNumeroSQL(NVL(cursor_4c_Barra.barraordem, 0), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.programas, "")), 15)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.parametros, "")), 10)) + ", " + ;
                                   FormatarNumeroSQL(IIF(NVL(cursor_4c_Barra.selbarras, .F.), 1, 0), 0) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            loc_lErroBanco = .T.
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_lErroBanco
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacaoAberta = .F.
                    MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o dos dados. " + ;
                            "Favor tentar novamente.", "Erro de Grava" + CHR(231) + CHR(227) + "o")
                ELSE
                    SQLEXEC(gnConnHandle, "COMMIT")
                    loc_lTransacaoAberta = .F.
                    THIS.this_cGrupos      = ALLTRIM(par_cGrupo)
                    THIS.this_cGrupoNComps = ALLTRIM(par_cGrupo)
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarioPorCodigo - Retorna nome do usuario dado seu codigo
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarioPorCodigo(par_cCodigo)
        LOCAL loc_cNome, loc_oErro, loc_cSQL

        loc_cNome = ""

        TRY
            loc_cSQL = "SELECT NComps FROM SigCdUsu " + ;
                       "WHERE Usuarios = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuBuscaCod") > 0
                IF !EOF("cursor_4c_UsuBuscaCod")
                    loc_cNome = ALLTRIM(cursor_4c_UsuBuscaCod.NComps)
                ENDIF
                IF USED("cursor_4c_UsuBuscaCod")
                    USE IN cursor_4c_UsuBuscaCod
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarUsuarioPorCodigo")
        ENDTRY

        RETURN loc_cNome
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarioPorNome - Retorna codigo do usuario dado seu nome
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarioPorNome(par_cNome)
        RETURN ""
    ENDFUNC

ENDDEFINE
