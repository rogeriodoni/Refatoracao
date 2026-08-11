*==============================================================================
* DspBO.prg - Business Object para Cadastro de Disponibilidades
* Tabela: SigCdDis
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DspBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdDis
    *--------------------------------------------------------------------------
    this_cCodigos   = ""   && char(20) PK - gerado por SYS(2015)
    this_cGrupos    = ""   && char(10) FK -> SigCdGcr.Codigos
    this_cIclis     = ""   && char(10) FK -> SigCdCli.IClis
    this_nTipos     = 1    && numeric(1,0) 1=Disponibilidade 2=Investimento 3=Emprestimo

    *--------------------------------------------------------------------------
    * Campos auxiliares (nao persistidos - apenas para exibicao no form)
    *--------------------------------------------------------------------------
    this_cDsGrupo   = ""   && descricao do grupo (SigCdGcr.Descrs)
    this_cDsConta   = ""   && descricao da conta (SigCdCli.RClis)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDis"
            THIS.this_cCampoChave = "Cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de disponibilidades no cursor cursor_4c_Dados
    * par_cFiltro: filtro SQL adicional (vazio = todos)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.Cidchaves AS Codigos, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Contas AS Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Contas"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Contas"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_Dados
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar disponibilidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega disponibilidade pelo Codigos (PK)
    * par_cCodigo: valor do Codigos
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.Cidchaves AS Codigos, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Contas AS Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Contas" + ;
                       " WHERE a.Cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * par_cAliasCursor: nome do cursor (SELECT antes de acessar campos)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos   = TratarNulo(Codigos,  "C")
                THIS.this_cGrupos    = TratarNulo(Grupos,   "C")
                THIS.this_cIclis     = TratarNulo(Iclis,    "C")
                THIS.this_nTipos     = TratarNulo(Tipos,    "N")
                THIS.this_cDsGrupo   = TratarNulo(DsGrupos, "C")
                THIS.this_cDsConta   = TratarNulo(DsConta,  "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Insere nova disponibilidade (PROTECTED)
    * Gera Codigos via SYS(2015), verifica duplicidade antes de INSERT
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, "")
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.this_cCodigos = LEFT(SYS(2015) + SYS(2015), 20)

                loc_cSQL = "INSERT INTO SigCdDis (Cidchaves, Grupos, Contas, Tipos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCodigos)               + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cGrupos, 10))      + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cIclis, 10))       + ", " + ;
                           FormatarNumeroSQL(THIS.this_nTipos)          + ;
                           ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza disponibilidade existente (PROTECTED)
    * Verifica duplicidade (excluindo o registro atual) antes de UPDATE
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, THIS.this_cCodigos)
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "UPDATE SigCdDis SET" + ;
                           " Grupos   = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                           " Contas   = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))  + "," + ;
                           " Tipos    = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
                           " WHERE Cidchaves = " + EscaparSQL(THIS.this_cCodigos)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui disponibilidade (PROTECTED)
    * Chamado internamente por Excluir() do BusinessBase
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDis WHERE Cidchaves = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com Grupos+Iclis
    * par_cGrupos: codigo do grupo (SigCdDis.Grupos)
    * par_cContas: codigo da conta (SigCdDis.Iclis)
    * par_cExcluirChave: PK a excluir da verificacao (vazio=INSERT, atual=UPDATE)
    * Retorna: .T. se duplicado, .F. se nao existe
    *==========================================================================
    PROCEDURE VerificarDuplicidade(par_cGrupos, par_cContas, par_cExcluirChave)
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Duplic")
                USE IN cursor_4c_Duplic
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDis" + ;
                       " WHERE Contas = " + EscaparSQL(par_cContas)

            IF VARTYPE(par_cExcluirChave) = "C" AND !EMPTY(ALLTRIM(par_cExcluirChave))
                loc_cSQL = loc_cSQL + " AND Cidchaves <> " + EscaparSQL(par_cExcluirChave)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Duplic") > 0
                SELECT cursor_4c_Duplic
                loc_lDuplicado = (Total > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Duplic")
            USE IN cursor_4c_Duplic
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Valida codigo de grupo e carrega descricao
    * par_cGrupo: codigo do grupo (SigCdGcr.Codigos)
    * Retorna: .T. se valido | Efeito: popula this_cDsGrupo
    *==========================================================================
    PROCEDURE ValidarGrupo(par_cGrupo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_ValGrupo")
                USE IN cursor_4c_ValGrupo
            ENDIF

            IF EMPTY(ALLTRIM(par_cGrupo))
                THIS.this_cDsGrupo = ""
            ELSE
                loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(par_cGrupo)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrupo")

                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValGrupo") > 0
                    SELECT cursor_4c_ValGrupo
                    THIS.this_cDsGrupo = ALLTRIM(cursor_4c_ValGrupo.Descrs)
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cDsGrupo = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ValGrupo")
            USE IN cursor_4c_ValGrupo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarConta - Valida codigo de conta (SigCdCli.IClis)
    * par_cGrupo: nao utilizado no filtro SQL
    * par_cConta: codigo da conta (SigCdCli.IClis)
    * Retorna: .T. se valida | Efeito: popula this_cDsConta
    *==========================================================================
    PROCEDURE ValidarConta(par_cGrupo, par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_ValConta")
                USE IN cursor_4c_ValConta
            ENDIF

            IF EMPTY(ALLTRIM(par_cConta))
                THIS.this_cDsConta = ""
            ELSE
                loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(par_cConta)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")

                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValConta") > 0
                    SELECT cursor_4c_ValConta
                    THIS.this_cDsConta = ALLTRIM(cursor_4c_ValConta.Rclis)
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cDsConta = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar conta: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ValConta")
            USE IN cursor_4c_ValConta
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarGrupos - Popula cursor_4c_BuscaGrupo para lookup de grupos
    * par_cFiltro: prefixo para filtrar por Codigos (vazio = todos)
    *==========================================================================
    PROCEDURE BuscarGrupos(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE Codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_BuscaGrupo
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarContas - Popula cursor_4c_BuscaConta para lookup de contas
    * par_cGrupo: nao utilizado no filtro SQL
    * par_cFiltro: prefixo para filtrar por Iclis (vazio = todos)
    *==========================================================================
    PROCEDURE BuscarContas(par_cGrupo, par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
        loc_lResultado = .F.
        loc_cWhere     = ""

        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE Iclis LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + loc_cWhere + " ORDER BY Iclis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_BuscaConta
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar contas: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
