*==============================================================================
* OpdBO.prg - Business Object para Opera??es de Pedido (SigOpPed)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS OpdBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (mapeamento das colunas de SigOpPed)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && cidchaves char(20) - identificador interno
    this_cDopes     = ""   && dopes     char(20) - PK: descri��o da opera��o
    this_nNdopes    = 0    && ndopes    numeric(10,0) - c�digo num�rico
    this_nTpagos    = 0    && tpagos    numeric(10,0) - tipo pagamento (1=Pagos,2=N�o Pagos,3=Todos)
    this_nTutils    = 0    && tutils    numeric(10,0) - tipo utiliza��o (1=Utilizados,2=N�o Utilizados,3=Todos)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = "SigOpPed"
                THIS.this_cCampoChave = "Dopes"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDopes     = TratarNulo(dopes,     "C")
                THIS.this_nNdopes    = TratarNulo(ndopes,    "N")
                THIS.this_nTpagos    = TratarNulo(tpagos,   "N")
                THIS.this_nTutils    = TratarNulo(tutils,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "OpdBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopes)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTpagos < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Pagamento!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTutils < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Utiliza" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDopesExistente(THIS.this_cDopes)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + " Cadastrada!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDopesExistente - Verifica se dopes ja existe em SigOpPed
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDopesExistente(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpPed" + ;
                " WHERE dopes = " + EscaparSQL(par_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpd")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOpd")
                SELECT cursor_4c_ChkOpd
                loc_lExiste = (cursor_4c_ChkOpd.qtd > 0)
                USE IN cursor_4c_ChkOpd
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "OpdBO.VerificarDopesExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves se nao definido (equivalente ao fUniqueIds() do legado)
            loc_cCidChaves = ALLTRIM(THIS.this_cCidChaves)
            IF EMPTY(loc_cCidChaves)
                loc_cCidChaves = PADR(ALLTRIM(THIS.this_cDopes), 20)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpPed (cidchaves, dopes, ndopes, tpagos, tutils)
                VALUES (
                    <<EscaparSQL(PADR(loc_cCidChaves, 20))>>,
                    <<EscaparSQL(THIS.this_cDopes)>>,
                    <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChaves = loc_cCidChaves
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "OpdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigOpPed
    * Nota: dopes e a PK, nao pode ser alterado - apenas ndopes, tpagos, tutils
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpPed
                SET ndopes = <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    tpagos = <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    tutils = <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                WHERE dopes = <<EscaparSQL(THIS.this_cDopes)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "OpdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpPed WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "OpdBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com ndopes, dopes, tpagos, tutils
    * Grid colunas 3 e 4 usam IIF no ControlSource para exibir texto
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (ndopes N(10,0), dopes C(20), tpagos N(10,0), tutils N(10,0), desc_pagos C(20), desc_utils C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT ndopes, dopes, tpagos, tutils," + ;
                    " CASE WHEN tpagos = 1 THEN 'Pagos'" + ;
                    " WHEN tpagos = 2 THEN 'Nao Pagos' ELSE 'Todos' END AS desc_pagos," + ;
                    " CASE WHEN tutils = 1 THEN 'Utilizados'" + ;
                    " WHEN tutils = 2 THEN 'Nao Utilizados' ELSE 'Todos' END AS desc_utils" + ;
                    " FROM SigOpPed"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY ndopes"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "OpdBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (dopes)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, dopes, ndopes, tpagos, tutils" + ;
                " FROM SigOpPed WHERE dopes = " + EscaparSQL(par_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "OpdBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
