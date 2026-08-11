*==============================================================================
* gemBO.prg - Business Object para Grupo Empresarial (SigCdGre)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS gemBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos da tabela SigCdGre
    *--------------------------------------------------------------------------
    this_cClass     = ""   && class     C(15) - Classificacao
    this_cGruClass  = ""   && gruclass  C(30) - grupo+class concatenado (PK)
    this_cGrupo     = ""   && grupo     C(15) - Grupo
    this_nTipos     = 1    && tipos     N(1,0) - 1=Industrial, 2=Diversos

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGre"
        THIS.this_cCampoChave = "gruclass"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (grupo C(15), class C(15), gruclass C(30), tipos N(1,0))
            ENDIF

            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupo, class, gruclass, tipos" + ;
                           " FROM SigCdGre"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY grupo, class"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado > 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar dados: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo gruclass (grupo+class)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT grupo, class, gruclass, tipos" + ;
                       " FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupo    = TratarNulo(grupo,    "C")
            THIS.this_cClass    = TratarNulo(class,    "C")
            THIS.this_cGruClass = TratarNulo(gruclass, "C")
            THIS.this_nTipos    = TratarNulo(tipos,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna gruclass para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cGruClass
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicata - Verifica se grupo+class ja existe (usar antes de INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicata, loc_cGruClass
        loc_lDuplicata = .F.

        TRY
            loc_cGruClass = ALLTRIM(THIS.this_cGrupo) + ALLTRIM(THIS.this_cClass)
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(loc_cGruClass)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
                SELECT cursor_4c_DupCheck
                loc_lDuplicata = (qtd > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar duplicata: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DupCheck")
            USE IN cursor_4c_DupCheck
        ENDIF

        RETURN loc_lDuplicata
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdGre (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGruClass
        loc_lSucesso = .F.

        TRY
            *-- gruclass = grupo+class concatenado (chave natural da tabela)
            loc_cGruClass = ALLTRIM(THIS.this_cGrupo) + ALLTRIM(THIS.this_cClass)
            THIS.this_cGruClass = loc_cGruClass

            loc_cSQL = "INSERT INTO SigCdGre (grupo, class, gruclass, tipos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cGrupo) + ", " + ;
                       EscaparSQL(THIS.this_cClass) + ", " + ;
                       EscaparSQL(loc_cGruClass) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdGre (PROTECTED)
    * Nota: grupo e class nao sao editaveis no ALTERAR (apenas tipos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGre SET" + ;
                       " tipos = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
                       " WHERE gruclass = " + EscaparSQL(THIS.this_cGruClass)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdGre (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(THIS.this_cGruClass)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
