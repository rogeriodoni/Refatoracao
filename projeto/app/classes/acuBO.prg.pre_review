*******************************************************************************
* acuBO.prg - Business Object para Cadastro de Usuarios
* Tabela principal: sigcdusu (PK: usuarios)
* Tabelas relacionadas: sigcdacg, sigcdace, sigcdacu, sigcdacb
*******************************************************************************

DEFINE CLASS acuBO AS BusinessBase

    *-- Propriedades da tabela sigcdusu
    this_cUsuarios    = ""  && usuarios char(10) - PK
    this_cNComps      = ""  && ncomps char(30) - nome completo
    this_cSenhas      = ""  && senhas char(10)
    this_cCCargs      = ""  && ccargs char(10) - codigo do cargo
    this_cLimDescs    = ""  && limdescs char(1) - senha do dia (S/N)
    this_cDeptos      = ""  && deptos char(10) - departamento
    this_cLibPess     = ""  && libpess char(1) - libera pesagem (S/N)
    this_cLibProds    = ""  && libprods char(1) - libera producao (S/N)
    this_cSetores     = ""  && setores char(10)
    this_cCativos     = ""  && cativos char(1) - ativo (S/N)
    this_cSupervis    = ""  && supervis char(1)
    this_cMbioDigs    = ""  && mbiodigs text NULL
    this_dTdtSenhas   = {}  && tdtsenhas datetime NULL - data/hora troca senha
    this_cIClis       = ""  && iclis char(10) - codigo cliente vinculado
    this_nObrigSenhas = 0   && obrigsenhas numeric(1,0) - obriga cadastro de senha
    this_cLibQtMins   = ""  && libqtmins char(1) - libera movimentacao (S/N)
    this_cFigJpgSuser = ""  && figjpgsuser text NULL - foto do usuario

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdusu"
        THIS.this_cCampoChave = "usuarios"
        RETURN .T.
    ENDPROC

    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuarios)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cUsuarios    = TratarNulo(usuarios,    "C")
            THIS.this_cNComps      = TratarNulo(ncomps,      "C")
            THIS.this_cSenhas      = TratarNulo(senhas,      "C")
            THIS.this_cCCargs      = TratarNulo(ccargs,      "C")
            THIS.this_cLimDescs    = TratarNulo(limdescs,    "C")
            THIS.this_cDeptos      = TratarNulo(deptos,      "C")
            THIS.this_cLibPess     = TratarNulo(libpess,     "C")
            THIS.this_cLibProds    = TratarNulo(libprods,    "C")
            THIS.this_cSetores     = TratarNulo(setores,     "C")
            THIS.this_cCativos     = TratarNulo(cativos,     "C")
            THIS.this_cSupervis    = TratarNulo(supervis,    "C")
            THIS.this_cIClis       = TratarNulo(iclis,       "C")
            THIS.this_nObrigSenhas = TratarNulo(obrigsenhas, "N")
            THIS.this_cLibQtMins   = TratarNulo(libqtmins,   "C")
            IF !ISNULL(tdtsenhas)
                THIS.this_dTdtSenhas = tdtsenhas
            ELSE
                THIS.this_dTdtSenhas = {}
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista usuarios com filtro opcional (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, cativos" + ;
                           " FROM sigcdusu" + ;
                           " ORDER BY usuarios"
            ELSE
                loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, cativos" + ;
                           " FROM sigcdusu" + ;
                           " WHERE UPPER(usuarios) LIKE UPPER(" + EscaparSQL("%" + par_cFiltro + "%") + ")" + ;
                           " OR UPPER(ncomps) LIKE UPPER(" + EscaparSQL("%" + par_cFiltro + "%") + ")" + ;
                           " ORDER BY usuarios"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega usuario pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cUsuarios)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM sigcdusu" + ;
                       " WHERE usuarios = " + EscaparSQL(par_cUsuarios)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela sigcdusu (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO sigcdusu" + ;
                       " (usuarios, ncomps, senhas, ccargs, limdescs, deptos," + ;
                       "  libpess, libprods, setores, cativos, supervis, iclis," + ;
                       "  obrigsenhas, libqtmins)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cUsuarios)    + "," + ;
                       EscaparSQL(THIS.this_cNComps)      + "," + ;
                       EscaparSQL(THIS.this_cSenhas)      + "," + ;
                       EscaparSQL(THIS.this_cCCargs)      + "," + ;
                       EscaparSQL(THIS.this_cLimDescs)    + "," + ;
                       EscaparSQL(THIS.this_cDeptos)      + "," + ;
                       EscaparSQL(THIS.this_cLibPess)     + "," + ;
                       EscaparSQL(THIS.this_cLibProds)    + "," + ;
                       EscaparSQL(THIS.this_cSetores)     + "," + ;
                       EscaparSQL(THIS.this_cCativos)     + "," + ;
                       EscaparSQL(THIS.this_cSupervis)    + "," + ;
                       EscaparSQL(THIS.this_cIClis)       + "," + ;
                       FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
                       EscaparSQL(THIS.this_cLibQtMins)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela sigcdusu (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdusu SET" + ;
                       "  ncomps      = " + EscaparSQL(THIS.this_cNComps)      + "," + ;
                       "  ccargs      = " + EscaparSQL(THIS.this_cCCargs)      + "," + ;
                       "  limdescs    = " + EscaparSQL(THIS.this_cLimDescs)    + "," + ;
                       "  deptos      = " + EscaparSQL(THIS.this_cDeptos)      + "," + ;
                       "  libpess     = " + EscaparSQL(THIS.this_cLibPess)     + "," + ;
                       "  libprods    = " + EscaparSQL(THIS.this_cLibProds)    + "," + ;
                       "  setores     = " + EscaparSQL(THIS.this_cSetores)     + "," + ;
                       "  cativos     = " + EscaparSQL(THIS.this_cCativos)     + "," + ;
                       "  supervis    = " + EscaparSQL(THIS.this_cSupervis)    + "," + ;
                       "  iclis       = " + EscaparSQL(THIS.this_cIClis)       + "," + ;
                       "  obrigsenhas = " + FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
                       "  libqtmins   = " + EscaparSQL(THIS.this_cLibQtMins)   + ;
                       " WHERE usuarios = " + EscaparSQL(THIS.this_cUsuarios)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Upd")
            USE IN cursor_4c_Upd
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em cascata (sigcdacu,sigcdacg,sigcdace,sigcdacb,sigcdusu)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cUsuarios, loc_nResultado
        loc_lSucesso = .F.
        loc_cUsuarios = EscaparSQL(THIS.this_cUsuarios)

        TRY
            *-- Remover acessos relacionados em cascata
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacu WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAcu")
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_DlAcu")
                    USE IN cursor_4c_DlAcu
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM sigcdacg WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAcg")
                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_DlAcg")
                        USE IN cursor_4c_DlAcg
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM sigcdace WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAce")
                    IF loc_nResultado < 0
                        MsgErro("Erro ao excluir empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_DlAce")
                            USE IN cursor_4c_DlAce
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "DELETE FROM sigcdacb WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAcb")
                        IF loc_nResultado < 0
                            MsgErro("Erro ao excluir barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            IF USED("cursor_4c_DlAcb")
                                USE IN cursor_4c_DlAcb
                            ENDIF

                            loc_nResultado = SQLEXEC(gnConnHandle, ;
                                "DELETE FROM sigcdusu WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlUsu")
                            IF loc_nResultado >= 0
                                THIS.RegistrarAuditoria("DELETE")
                                loc_lSucesso = .T.
                            ELSE
                                MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            ENDIF
                            IF USED("cursor_4c_DlUsu")
                                USE IN cursor_4c_DlUsu
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega todos os grupos de acesso (sigcdgra)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGrupos()
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, dgrus FROM sigcdgra ORDER BY grupos", ;
                "cursor_4c_Grupos")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.BuscarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProgramas - Carrega todos os programas (sigcdprg)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProgramas()
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Programas")
                USE IN cursor_4c_Programas
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, descricaos, programas, parametros, barraforms," + ;
                " barratips, barrapicts, pkchaves, 0 AS marcas" + ;
                " FROM sigcdprg" + ;
                " ORDER BY descricaos, programas, parametros", ;
                "cursor_4c_Programas")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar programas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.BuscarProgramas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessosPorUsuario - Carrega acessos do usuario (sigcdacu)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessosPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Acessos")
                USE IN cursor_4c_Acessos
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, programas, parametros, usuarios, pkchaves" + ;
                " FROM sigcdacu" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_Acessos")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarAcessosPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposPorUsuario - Carrega grupos do usuario (sigcdacg)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGruposPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_GruposUsu")
                USE IN cursor_4c_GruposUsu
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, usuarios, pkchaves" + ;
                " FROM sigcdacg" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_GruposUsu")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarGruposPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresasPorUsuario - Carrega empresas do usuario (sigcdace)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresasPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_EmpresasUsu")
                USE IN cursor_4c_EmpresasUsu
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT e.usuarios, e.emps, e.pkchaves, c.razas" + ;
                " FROM sigcdace e" + ;
                " LEFT JOIN sigcdemp c ON RTRIM(c.cemps) = RTRIM(e.cemps)" + ;
                " WHERE e.usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_EmpresasUsu")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar empresas do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarEmpresasPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarraPorUsuario - Carrega barra de acesso do usuario (sigcdacb)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarraPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Barra")
                USE IN cursor_4c_Barra
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, usuarios, descricaos, barraforms, barraordem," + ;
                " programas, parametros, selbarras, pkchaves" + ;
                " FROM sigcdacb" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios) + ;
                " ORDER BY barraordem", ;
                "cursor_4c_Barra")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar barra do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarBarraPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessos - Grava programas marcados em sigcdacu (substitui todos)
    * par_cUsuarios: codigo do usuario
    * par_cCursorPrg: cursor com programas (campo marcas=1 = tem acesso)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessos(par_cUsuarios, par_cCursorPrg)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK
        loc_lSucesso = .F.

        TRY
            *-- Apaga acessos existentes do usuario
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacu WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAcu2")
            IF USED("cursor_4c_DlAcu2")
                USE IN cursor_4c_DlAcu2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Insere apenas os programas marcados
                IF USED(par_cCursorPrg) AND RECCOUNT(par_cCursorPrg) > 0
                    SELECT (par_cCursorPrg)
                    GO TOP
                    SCAN FOR marcas = 1
                        loc_cPK = ALLTRIM(usuarios) + ALLTRIM(grupos) + ;
                                  ALLTRIM(programas) + ALLTRIM(parametros)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacu (grupos, parametros, programas, usuarios, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(grupos))     + "," + ;
                            EscaparSQL(ALLTRIM(parametros)) + "," + ;
                            EscaparSQL(ALLTRIM(programas))  + "," + ;
                            EscaparSQL(par_cUsuarios)       + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 45))   + ;
                            ")", "cursor_4c_InsAcu")
                        IF USED("cursor_4c_InsAcu")
                            USE IN cursor_4c_InsAcu
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarAcessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Grava grupos marcados em sigcdacg (substitui todos)
    * par_cUsuarios: codigo do usuario
    * par_cCursorGru: cursor com grupos (campo marca=1 = tem acesso)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGrupos(par_cUsuarios, par_cCursorGru)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK
        loc_lSucesso = .F.

        TRY
            *-- Apaga grupos existentes do usuario
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacg WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAcg2")
            IF USED("cursor_4c_DlAcg2")
                USE IN cursor_4c_DlAcg2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorGru) AND RECCOUNT(par_cCursorGru) > 0
                    SELECT (par_cCursorGru)
                    GO TOP
                    SCAN FOR marca = 1
                        loc_cPK = ALLTRIM(par_cUsuarios) + ALLTRIM(grupos)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(grupos)) + "," + ;
                            EscaparSQL(par_cUsuarios)   + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 20)) + ;
                            ")", "cursor_4c_InsAcg")
                        IF USED("cursor_4c_InsAcg")
                            USE IN cursor_4c_InsAcg
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarEmpresas - Grava empresas marcadas em sigcdace (substitui todas)
    * par_cUsuarios: codigo do usuario
    * par_cCursorEmp: cursor com empresas (campo marcas=.T. = tem acesso)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarEmpresas(par_cUsuarios, par_cCursorEmp)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdace WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAce2")
            IF USED("cursor_4c_DlAce2")
                USE IN cursor_4c_DlAce2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorEmp) AND RECCOUNT(par_cCursorEmp) > 0
                    SELECT (par_cCursorEmp)
                    GO TOP
                    SCAN FOR marcas
                        loc_cPK = ALLTRIM(par_cUsuarios) + ALLTRIM(emps)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdace (usuarios, emps, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(par_cUsuarios)        + "," + ;
                            EscaparSQL(ALLTRIM(emps))        + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 13))    + ;
                            ")", "cursor_4c_InsAce")
                        IF USED("cursor_4c_InsAce")
                            USE IN cursor_4c_InsAce
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir empresa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarBarra - Grava barra selecionada em sigcdacb (substitui todos)
    * par_cUsuarios: codigo do usuario
    * par_cCursorBarra: cursor TmpBarra com campos SelBarras, Usuarios, etc.
    *--------------------------------------------------------------------------
    PROCEDURE SalvarBarra(par_cUsuarios, par_cCursorBarra)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK, loc_nOrdem
        loc_lSucesso = .F.
        loc_nOrdem   = 0

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacb WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAcb2")
            IF USED("cursor_4c_DlAcb2")
                USE IN cursor_4c_DlAcb2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorBarra) AND RECCOUNT(par_cCursorBarra) > 0
                    SELECT (par_cCursorBarra)
                    SET ORDER TO BarraOrdem
                    GO TOP
                    SCAN FOR !EMPTY(ALLTRIM(usuarios))
                        loc_nOrdem = loc_nOrdem + 1
                        loc_cPK = ALLTRIM(par_cUsuarios) + ALLTRIM(grupos) + ;
                                  ALLTRIM(programas) + ALLTRIM(parametros)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem," + ;
                            "  programas, parametros, selbarras, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(grupos))      + "," + ;
                            EscaparSQL(par_cUsuarios)        + "," + ;
                            EscaparSQL(LEFT(ALLTRIM(descricaos), 73)) + "," + ;
                            EscaparSQL(LEFT(ALLTRIM(barraforms), 50)) + "," + ;
                            FormatarNumeroSQL(loc_nOrdem)    + "," + ;
                            EscaparSQL(ALLTRIM(programas))   + "," + ;
                            EscaparSQL(ALLTRIM(parametros))  + "," + ;
                            IIF(selbarras, "1", "0")         + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 20))    + ;
                            ")", "cursor_4c_InsAcb")
                        IF USED("cursor_4c_InsAcb")
                            USE IN cursor_4c_InsAcb
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarBarra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparSenha - Reseta a senha do usuario para vazio
    *--------------------------------------------------------------------------
    PROCEDURE LimparSenha(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE sigcdusu SET senhas = ''" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_LimSen")
            IF USED("cursor_4c_LimSen")
                USE IN cursor_4c_LimSen
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE-SENHA")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao limpar senha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.LimparSenha:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarUsuarioExistente - Verifica se um usuario ja esta cadastrado
    *--------------------------------------------------------------------------
    PROCEDURE VerificarUsuarioExistente(par_cUsuarios)
        LOCAL loc_lExiste, loc_nResultado
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_VerUsu")
                USE IN cursor_4c_VerUsu
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 usuarios FROM sigcdusu" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_VerUsu")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VerUsu") > 0
                loc_lExiste = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.VerificarUsuarioExistente:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VerUsu")
            USE IN cursor_4c_VerUsu
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarAcessos - Copia acessos de um usuario para outro
    * par_cUsuOri: usuario de origem
    * par_cUsuDes: usuario de destino
    *--------------------------------------------------------------------------
    PROCEDURE CopiarAcessos(par_cUsuOri, par_cUsuDes)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Copiar sigcdacu (programas/acessos)
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "INSERT INTO sigcdacu (grupos, parametros, programas, usuarios, pkchaves)" + ;
                " SELECT a.grupos, a.parametros, a.programas," + ;
                " " + EscaparSQL(par_cUsuDes) + "," + ;
                " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.grupos + a.programas + a.parametros, 45)" + ;
                " FROM sigcdacu a" + ;
                " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                " AND a.programas + a.parametros NOT IN" + ;
                " (SELECT b.programas + b.parametros FROM sigcdacu b" + ;
                "  WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                "cursor_4c_CpAcu")
            IF USED("cursor_4c_CpAcu")
                USE IN cursor_4c_CpAcu
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao copiar acessos (acu):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Copiar sigcdacg (grupos)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                    " SELECT a.grupos," + ;
                    " " + EscaparSQL(par_cUsuDes) + "," + ;
                    " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.grupos, 20)" + ;
                    " FROM sigcdacg a" + ;
                    " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                    " AND a.grupos NOT IN" + ;
                    " (SELECT b.grupos FROM sigcdacg b WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                    "cursor_4c_CpAcg")
                IF USED("cursor_4c_CpAcg")
                    USE IN cursor_4c_CpAcg
                ENDIF

                IF loc_nResultado < 0
                    MsgErro("Erro ao copiar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Copiar sigcdace (empresas)
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "INSERT INTO sigcdace (usuarios, emps, pkchaves)" + ;
                        " SELECT " + EscaparSQL(par_cUsuDes) + ", a.emps," + ;
                        " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.emps, 13)" + ;
                        " FROM sigcdace a" + ;
                        " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                        " AND a.emps NOT IN" + ;
                        " (SELECT b.emps FROM sigcdace b WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                        "cursor_4c_CpAce")
                    IF USED("cursor_4c_CpAce")
                        USE IN cursor_4c_CpAce
                    ENDIF

                    IF loc_nResultado < 0
                        MsgErro("Erro ao copiar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- Copiar sigcdacb (barra)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem," + ;
                            "  programas, parametros, selbarras, pkchaves)" + ;
                            " SELECT a.grupos, " + EscaparSQL(par_cUsuDes) + "," + ;
                            " a.descricaos, a.barraforms, a.barraordem," + ;
                            " a.programas, a.parametros, a.selbarras," + ;
                            " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.grupos + a.programas + a.parametros, 20)" + ;
                            " FROM sigcdacb a" + ;
                            " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                            " AND a.programas + a.parametros NOT IN" + ;
                            " (SELECT b.programas + b.parametros FROM sigcdacb b" + ;
                            "  WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                            "cursor_4c_CpAcb")
                        IF USED("cursor_4c_CpAcb")
                            USE IN cursor_4c_CpAcb
                        ENDIF

                        IF loc_nResultado < 0
                            MsgErro("Erro ao copiar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CopiarAcessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
