*==============================================================================
* SigOpCacBO.prg - Business Object para Consulta de Acesso a Programas
* Herda de: BusinessBase
* Origem: SIGOPCAC.SCX (form operacional, somente consulta)
* Tabelas: SigCdPrg (programas/parametros), SigCdAcu (acesso por grupo/usuario),
*          SigCdUsu (usuarios), SigCdAcG (usuarios por grupo)
*
* Form somente-leitura: nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao().
* O comportamento padrao herdado de BusinessBase ja eh o correto para esta tela.
*==============================================================================

DEFINE CLASS SigOpCacBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao do BusinessBase
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdPrg"
    this_cCampoChave = "programas"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO e pre-carrega o cursor de programas/parametros
    * (equivalente ao poDataMgr.SqlExecute(...,'crSigCdPrg1') do Init legado)
    *--------------------------------------------------------------------------
    * O pre-carregamento do cursor de programas eh um CACHE, nao pre-requisito:
    * BuscarPrograma() refaz a carga sob demanda (IF !USED(...)). Por isso o Init
    * devolve .T. mesmo quando a carga falha - devolver .F. faria o
    * CREATEOBJECT("SigOpCacBO") virar .F. e o Form abortaria o proprio Init,
    * deixando a tela sem abrir por uma falha de cache. O legado tambem nao
    * aborta: o Init dele so roda o SqlExecute do crSigCdPrg1.
    FUNCTION Init()
        LOCAL loc_oErro, loc_lValidandoUI

        TRY
            DODEFAULT()

            *-- Nao executa SQL durante validacao de UI / teste automatizado,
            *-- em que gnConnHandle = -1 (padrao canonico do projeto).
            loc_lValidandoUI = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                               (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

            IF !loc_lValidandoUI
                THIS.CarregarProgramas()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.Init")
        ENDTRY

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarProgramas - Popula cursor_4c_Programas com descricaos/programas/
    * parametros de SigCdPrg, com Descricaos em MAIUSCULO (Replace All do legado)
    *--------------------------------------------------------------------------
    FUNCTION CarregarProgramas()
        LOCAL loc_lSucesso, loc_oErro, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Programas")
                USE IN cursor_4c_Programas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT descricaos, programas, parametros FROM SigCdPrg", ;
                "cursor_4c_Programas")

            IF loc_nResult >= 0
                SELECT cursor_4c_Programas
                REPLACE ALL descricaos WITH UPPER(descricaos) IN cursor_4c_Programas
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar programas cadastrados." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.CarregarProgramas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarPrograma - Procura par_cTexto em cursor_4c_Programas.descricaos
    * (equivalente ao Valid do Text1 legado, sem a resolucao do browse -
    * a decisao de match unico/multiplo/vazio fica no Form)
    * Resultado em cursor_4c_ProgramaBusca (descricaos, programas, parametros)
    *--------------------------------------------------------------------------
    FUNCTION BuscarPrograma(par_cTexto)
        LOCAL loc_lSucesso, loc_oErro, loc_cBusca

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Programas")
                THIS.CarregarProgramas()
            ENDIF

            IF USED("cursor_4c_Programas")
                loc_cBusca = "%" + UPPER(ALLTRIM(par_cTexto)) + "%"

                IF USED("cursor_4c_ProgramaBusca")
                    USE IN cursor_4c_ProgramaBusca
                ENDIF

                SELECT descricaos, programas, parametros FROM cursor_4c_Programas ;
                    WHERE descricaos LIKE loc_cBusca ;
                    INTO CURSOR cursor_4c_ProgramaBusca READWRITE

                loc_lSucesso = (RECCOUNT("cursor_4c_ProgramaBusca") > 0)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.BuscarPrograma")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Popula cursor_4c_Grupos com os grupos de acesso ao
    * programa/parametro informados (equivalente ao Command1.Click legado)
    * Mantem a linha de grupo VAZIO quando ela nao existir no resultado
    * (legado: If Eof() or !Empty(Grupos) then Append Blank), que representa
    * acesso por supervisor/individual sem grupo especifico.
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cPrograma, par_cParametro)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cProg, loc_cParm

        loc_lSucesso = .F.
        loc_cProg    = ALLTRIM(par_cPrograma)
        loc_cParm    = ALLTRIM(par_cParametro)

        TRY
            loc_cSQL = "SELECT DISTINCT grupos FROM SigCdAcu " + ;
                       "WHERE programas = " + EscaparSQL(loc_cProg)

            IF !EMPTY(loc_cParm)
                loc_cSQL = loc_cSQL + " AND parametros = " + EscaparSQL(loc_cParm)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY grupos"

            IF USED("cursor_4c_GruposTmp")
                USE IN cursor_4c_GruposTmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTmp")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF

                SELECT grupos FROM cursor_4c_GruposTmp INTO CURSOR cursor_4c_Grupos READWRITE

                IF USED("cursor_4c_GruposTmp")
                    USE IN cursor_4c_GruposTmp
                ENDIF

                SELECT cursor_4c_Grupos
                GO TOP

                IF EOF("cursor_4c_Grupos") OR !EMPTY(cursor_4c_Grupos.grupos)
                    APPEND BLANK IN cursor_4c_Grupos
                ENDIF

                SELECT cursor_4c_Grupos
                INDEX ON grupos TAG grupos
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao consultar grupos de acesso." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.BuscarGrupos")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarios - Popula cursor_4c_Usuarios com os usuarios do grupo
    * selecionado (equivalente ao AfterRowColChange do Grid1 legado)
    *
    * par_cGrupo VAZIO -> usuarios supervisores (Supervis IN 'S','I') UNION
    *   usuarios com acesso INDIVIDUAL ao programa/parametro (SigCdAcu com
    *   Grupos em branco)
    * par_cGrupo preenchido -> usuarios vinculados a esse grupo via SigCdAcG
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarios(par_cGrupo, par_cPrograma, par_cParametro)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        LOCAL loc_cGrupo, loc_cProg, loc_cParm

        loc_lSucesso = .F.
        loc_cGrupo   = ALLTRIM(par_cGrupo)
        loc_cProg    = ALLTRIM(par_cPrograma)
        loc_cParm    = ALLTRIM(par_cParametro)

        TRY
            IF EMPTY(loc_cGrupo)
                loc_cSQL = "SELECT DISTINCT usuarios, ncomps, ccargs, deptos, supervis, cativos " + ;
                           "FROM SigCdUsu WHERE supervis IN ('S','I') " + ;
                           "UNION " + ;
                           "SELECT DISTINCT b.usuarios, b.ncomps, b.ccargs, b.deptos, b.supervis, b.cativos " + ;
                           "FROM SigCdAcu a INNER JOIN SigCdUsu b ON a.usuarios = b.usuarios " + ;
                           "WHERE a.grupos = " + EscaparSQL(SPACE(10)) + " " + ;
                           "AND a.programas = " + EscaparSQL(loc_cProg)

                IF !EMPTY(loc_cParm)
                    loc_cSQL = loc_cSQL + " AND a.parametros = " + EscaparSQL(loc_cParm)
                ENDIF
            ELSE
                loc_cSQL = "SELECT DISTINCT a.usuarios, a.ncomps, a.ccargs, a.deptos, a.supervis, a.cativos " + ;
                           "FROM SigCdUsu a LEFT JOIN SigCdAcG b ON a.usuarios = b.usuarios " + ;
                           "WHERE b.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF USED("cursor_4c_UsuariosTmp")
                USE IN cursor_4c_UsuariosTmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosTmp")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Usuarios")
                    USE IN cursor_4c_Usuarios
                ENDIF

                SELECT usuarios, ncomps, ccargs, deptos, supervis, cativos ;
                    FROM cursor_4c_UsuariosTmp INTO CURSOR cursor_4c_Usuarios READWRITE

                IF USED("cursor_4c_UsuariosTmp")
                    USE IN cursor_4c_UsuariosTmp
                ENDIF

                SELECT cursor_4c_Usuarios
                INDEX ON usuarios TAG usuarios
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao consultar usuarios de acesso." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.BuscarUsuarios")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
