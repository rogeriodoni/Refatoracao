*====================================================================
* TpeBO.prg
*
* Business Object para Cadastro de Tipos de Etiquetas de Produto
* Tabela: SigCdTpe
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TpeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdTpe)
    this_nTipos      = 0     && ntipos numeric(3,0) - PK
    this_cEtiquetas  = ""    && cetiquetas char(30)
    this_nSituas     = 0     && nsituas numeric(1,0) - 0=Ativa, 1=Inativa
    this_cOrdems     = ""    && cordems char(3)
    this_nTpEspes    = 0     && tpespes numeric(3,0) - NENHUMA/TAG MODELO 1
    this_nCodObs     = 0     && codobs numeric(3,0) - FK SigCdObs
    this_nPadrao     = 0     && npadrao numeric(1,0) - NOT NULL, ausente na tela

    *-- Propriedade auxiliar somente-exibicao (nao persistida em SigCdTpe)
    this_cDescObs    = ""    && SigCdObs.descrs referente a this_nCodObs

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdTpe"
            THIS.this_cCampoChave = "ntipos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TpeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria (ntipos) para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nTipos)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nTipos     = TratarNulo(ntipos,     "N")
                THIS.this_cEtiquetas = TratarNulo(cetiquetas, "C")
                THIS.this_nSituas    = TratarNulo(nsituas,    "N")
                THIS.this_cOrdems    = TratarNulo(cordems,    "C")
                THIS.this_nTpEspes   = TratarNulo(tpespes,    "N")
                THIS.this_nCodObs    = TratarNulo(codobs,     "N")
                THIS.this_nPadrao    = TratarNulo(npadrao,    "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TpeBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Transcrito do legado (Pagina.Dados.Grupo_Salva.Salva.Click):
    *   - Descricao da Etiqueta e obrigatoria
    *   - Na INCLUSAO, ntipos e cetiquetas nao podem se repetir (ChkRegister)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cEtiquetas))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Etiqueta " + CHR(233) + ;
                " informa" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarTipoExistente(THIS.this_nTipos)
                MsgAviso("Tipo de Etiqueta j" + CHR(225) + " cadastrado.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarEtiquetaExistente(THIS.this_cEtiquetas)
                MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Permitido Etiquetas com a mesma descri" + ;
                    CHR(231) + CHR(227) + "o.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * AntesDeGravar - Normaliza cOrdems antes de gravar
    * Transcrito do legado: Replace cOrdems With PadL(AllTrim(Str(Val(cOrdems))),3)
    *====================================================================
    PROTECTED PROCEDURE AntesDeGravar()
        IF !EMPTY(ALLTRIM(THIS.this_cOrdems))
            THIS.this_cOrdems = PADL(ALLTRIM(STR(VAL(THIS.this_cOrdems))), 3)
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * VerificarTipoExistente - Verifica se ntipos ja existe no banco
    *====================================================================
    PROCEDURE VerificarTipoExistente(par_nTipos)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdTpe" + ;
                " WHERE ntipos = " + FormatarNumeroSQL(par_nTipos, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTipo")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkTipo")
                SELECT cursor_4c_ChkTipo
                loc_lExiste = (cursor_4c_ChkTipo.qtd > 0)
                USE IN cursor_4c_ChkTipo
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar tipo:" + CHR(13) + loException.Message, "TpeBO.VerificarTipoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * VerificarEtiquetaExistente - Verifica se cetiquetas ja existe no banco
    *====================================================================
    PROCEDURE VerificarEtiquetaExistente(par_cEtiquetas)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdTpe" + ;
                " WHERE cetiquetas = " + EscaparSQL(par_cEtiquetas)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkEtiq")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkEtiq")
                SELECT cursor_4c_ChkEtiq
                loc_lExiste = (cursor_4c_ChkEtiq.qtd > 0)
                USE IN cursor_4c_ChkEtiq
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar etiqueta:" + CHR(13) + loException.Message, "TpeBO.VerificarEtiquetaExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdTpe
    * Todas as colunas sao NOT NULL - nenhuma pode ficar de fora do INSERT
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdTpe (ntipos, cetiquetas, nsituas, cordems, tpespes, codobs, npadrao)
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<EscaparSQL(THIS.this_cEtiquetas)>>,
                    <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    <<EscaparSQL(THIS.this_cOrdems)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpEspes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodObs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPadrao, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TpeBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdTpe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdTpe
                SET cetiquetas = <<EscaparSQL(THIS.this_cEtiquetas)>>,
                    nsituas    = <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    cordems    = <<EscaparSQL(THIS.this_cOrdems)>>,
                    tpespes    = <<FormatarNumeroSQL(THIS.this_nTpEspes, 0)>>,
                    codobs     = <<FormatarNumeroSQL(THIS.this_nCodObs, 0)>>,
                    npadrao    = <<FormatarNumeroSQL(THIS.this_nPadrao, 0)>>
                WHERE ntipos = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TpeBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdTpe
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdTpe WHERE ntipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TpeBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com ntipos, cetiquetas, nsituas, cordems
    * (mesmas colunas usadas na grade do legado: pColuna ntipos/cetiquetas/nsituas/cordems)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (ntipos N(3,0), cetiquetas C(30), nsituas N(1,0), cordems C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT ntipos, cetiquetas, nsituas, cordems FROM SigCdTpe"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY ntipos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar tipos de etiquetas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TpeBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (ntipos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT ntipos, cetiquetas, nsituas, cordems, tpespes, codobs, npadrao" + ;
                " FROM SigCdTpe WHERE ntipos = " + FormatarNumeroSQL(par_nCodigo, 0)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de Etiqueta n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar tipo de etiqueta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TpeBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarDescricaoObs - Retorna descrs de SigCdObs para exibicao (dobs)
    * Transcrito do legado (Grupo_op.Click):
    *   select descrs from SigCdObs where codigos = ?crSigCdTpe.codobs
    *====================================================================
    PROCEDURE BuscarDescricaoObs(par_nCodObs)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF VARTYPE(par_nCodObs) = "N" AND par_nCodObs > 0
            TRY
                loc_cSQL = "SELECT descrs FROM SigCdObs WHERE codigos = " + FormatarNumeroSQL(par_nCodObs, 0)

                IF USED("cursor_4c_DescObs")
                    USE IN cursor_4c_DescObs
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescObs")

                IF loc_nResultado >= 0 AND USED("cursor_4c_DescObs") AND RECCOUNT("cursor_4c_DescObs") > 0
                    loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_DescObs.descrs, "C"))
                ENDIF

                IF USED("cursor_4c_DescObs")
                    USE IN cursor_4c_DescObs
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao buscar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "TpeBO.BuscarDescricaoObs")
            ENDTRY
        ENDIF

        THIS.this_cDescObs = loc_cDescricao
        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE
