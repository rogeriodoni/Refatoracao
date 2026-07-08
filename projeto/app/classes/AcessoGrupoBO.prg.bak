*==============================================================================
* ACESSOGRUPOBO.PRG
* Business Object para entidade Grupo de Acesso (SigCdGra)
*
* Tabela Principal: SigCdGra
* Tabelas Relacionadas:
*   - SigCdAcG (Associacao Grupo-Usuario)
*   - SigCdAcU (Acessos de Usuario)
*   - SigCdAcB (Acessos de Barras/Icones)
*   - SigAcTel (Acessos de Campos em Telas)
*   - SigCdPrg (Programas/Acessos disponiveis)
*   - SigCdUsu (Usuarios)
*
* Campos: Grupos (PK), NComps
*
* REGRAS APLICADAS:
* - Nomenclatura: loc_ para locais, par_ para parametros, this_ para classe
* - Herda de BusinessBase
* - Usa EscaparSQL() para campos CHAR
* - Usa MostrarErro() com SQL completo para debug
* - Usa gnConnHandle para conexao global
*
* IMPORTANTE: Este BO gerencia logica complexa de gestao de acessos.
*             Nao eh um CRUD simples, mas uma gestao de relacionamentos N-N.
*==============================================================================

DEFINE CLASS AcessoGrupoBO AS BusinessBase

    *-- Propriedades da entidade SigCdGra
    this_cGrupo = ""          && Grupos CHAR(10) - Codigo do grupo (PK)
    this_cNomeCompleto = ""   && NComps CHAR(50) - Nome completo do grupo

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela = "SigCdGra"         && Nome EXATO da tabela
        THIS.this_cCampoChave = "Grupos"       && Campo chave primaria
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros na tabela SigCdGra
    * Parametros:
    *   par_cFiltro: Filtro WHERE (opcional)
    * Retorno: .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT Grupos, NComps
                FROM SigCdGra
                <<IIF(!EMPTY(par_cFiltro), " WHERE " + par_cFiltro, "")>>
                ORDER BY Grupos
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar grupos:" + CHR(13) + CHR(13) + ;
                           "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar grupos:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo do grupo
    * Parametros:
    *   par_cGrupo: Codigo do grupo
    * Retorno: .T. se encontrou, .F. se nao encontrou
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cGrupo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM SigCdGra WHERE Grupos = " + EscaparSQL(par_cGrupo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado < 0
                MostrarErro("Erro ao carregar grupo:" + CHR(13) + CHR(13) + ;
                           "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            IF RECCOUNT("cursor_4c_Carrega") = 0
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            THIS.this_lNovoRegistro = .F.  && OBRIGATORIO: Evita violacao de PK no Alterar

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar grupo:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para propriedades
    * Parametros:
    *   par_cAliasCursor: Alias do cursor com dados
    * Retorno: .T. se sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)           && Seleciona cursor primeiro
            THIS.this_cGrupo = TratarNulo(Grupos, "C")
            THIS.this_cNomeCompleto = TratarNulo(NComps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo grupo
    * Retorno: .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdGra (Grupos, NComps)
                VALUES (<<EscaparSQL(THIS.this_cGrupo)>>, <<EscaparSQL(THIS.this_cNomeCompleto)>>)
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo:" + CHR(13) + CHR(13) + ;
                           "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir grupo:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza grupo existente
    * Retorno: .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdGra
                SET NComps = <<EscaparSQL(THIS.this_cNomeCompleto)>>
                WHERE Grupos = <<EscaparSQL(THIS.this_cGrupo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo:" + CHR(13) + CHR(13) + ;
                           "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar grupo:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui grupo
    * IMPORTANTE: Nome correto do BusinessBase eh ExecutarExclusao, NAO Excluir
    * Retorno: .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            * Primeiro, excluir acessos relacionados (ordem de dependencia)
            * 1. SigCdAcG (Associacao Grupo-Usuario)
            loc_cSQL = "DELETE FROM SigCdAcG WHERE Grupos = " + EscaparSQL(THIS.this_cGrupo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir associa" + CHR(231) + CHR(245) + "es grupo-usu" + CHR(225) + "rio:" + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            * 2. SigCdAcU (Acessos de Usuario)
            loc_cSQL = "DELETE FROM SigCdAcU WHERE Grupos = " + EscaparSQL(THIS.this_cGrupo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir acessos de usu" + CHR(225) + "rio:" + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            * 3. SigCdAcB (Acessos de Barras/Icones)
            loc_cSQL = "DELETE FROM SigCdAcB WHERE Grupos = " + EscaparSQL(THIS.this_cGrupo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir acessos de barras:" + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            * 4. SigAcTel (Acessos de Campos em Telas)
            loc_cSQL = "DELETE FROM SigAcTel WHERE Grupos = " + EscaparSQL(THIS.this_cGrupo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir acessos de telas:" + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            * 5. Por fim, excluir o grupo
            loc_cSQL = "DELETE FROM SigCdGra WHERE Grupos = " + EscaparSQL(THIS.this_cGrupo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir grupo:" + CHR(13) + CHR(13) + ;
                           "SQL: " + loc_cSQL + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir grupo:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria para auditoria
    * Retorno: Valor da chave primaria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cGrupo
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes especificas do grupo
    * Retorno: .T. se valido, .F. se invalido
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        * Grupo obrigatorio
        IF EMPTY(THIS.this_cGrupo)
            MsgAviso("C" + CHR(243) + "digo do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!")
            RETURN .F.
        ENDIF

        * Nome completo obrigatorio
        IF EMPTY(THIS.this_cNomeCompleto)
            MsgAviso("Nome do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuarios - Busca usuarios disponiveis para adicionar ao grupo
    * Retorno: .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuarios()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL NOSHOW
                SELECT Usuarios, cAtivos
                FROM SigCdUsu
                WHERE cAtivos <> 'N'
                ORDER BY Usuarios
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuarios")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuariosDoGrupo - Busca usuarios ja associados ao grupo
    * Parametros:
    *   par_cGrupo: Codigo do grupo
    * Retorno: .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuariosDoGrupo(par_cGrupo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT Usuarios
                FROM SigCdAcG
                WHERE Grupos = <<EscaparSQL(par_cGrupo)>>
                ORDER BY Usuarios
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosGrupo")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar usu" + CHR(225) + "rios do grupo:" + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar usu" + CHR(225) + "rios do grupo:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProgramas - Busca programas/acessos disponiveis
    * Retorno: .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProgramas()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL NOSHOW
                SELECT Descricaos, Programas, Parametros, BarraForms
                FROM SigCdPrg
                ORDER BY Descricaos, Programas, Parametros
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Programas")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar programas:" + CHR(13) + CHR(13) + ;
                           CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar programas:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
