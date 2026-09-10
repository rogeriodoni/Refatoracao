*====================================================================
* TfiBO.prg
*
* Business Object para Cadastro de Tipos (Tipos de Fatura)
* Tabela: SigCdTif
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TfiBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdTif)
    this_cCodigo        = ""    && codigos    char(3)  - PK
    this_cDescricao     = ""    && descricaos char(40)
    this_cAdendo        = ""    && adendos    char(10)
    this_nPQtde         = 0     && pqtdes     numeric(9,2)
    this_nPValor        = 0     && pvalors    numeric(9,2)
    this_cAdendoCodigo  = ""    && adendocs   char(2)
    this_nOpcaoSNA      = 0     && opcsnas    numeric(1,0)
    this_nOOrig         = 0     && oorig      numeric(2,0)
    this_nOAdendo       = 0     && oaden      numeric(2,0)
    this_nOCor          = 0     && ocor       numeric(2,0)
    this_nOEmb          = 0     && oemb       numeric(2,0)
    this_nOTam          = 0     && otam       numeric(2,0)
    this_nTamDesc       = 0     && tamdesc    numeric(2,0)
    this_nTipoDesc      = 0     && tpdescs    numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdTif"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TfiBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

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
                THIS.this_cCodigo       = TratarNulo(codigos,    "C")
                THIS.this_cDescricao    = TratarNulo(descricaos, "C")
                THIS.this_cAdendo       = TratarNulo(adendos,    "C")
                THIS.this_nPQtde        = TratarNulo(pqtdes,     "N")
                THIS.this_nPValor       = TratarNulo(pvalors,    "N")
                THIS.this_cAdendoCodigo = TratarNulo(adendocs,   "C")
                THIS.this_nOpcaoSNA     = TratarNulo(opcsnas,    "N")
                THIS.this_nOOrig        = TratarNulo(oorig,      "N")
                THIS.this_nOAdendo      = TratarNulo(oaden,      "N")
                THIS.this_nOCor         = TratarNulo(ocor,       "N")
                THIS.this_nOEmb         = TratarNulo(oemb,       "N")
                THIS.this_nOTam         = TratarNulo(otam,       "N")
                THIS.this_nTamDesc      = TratarNulo(tamdesc,    "N")
                THIS.this_nTipoDesc     = TratarNulo(tpdescs,    "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TfiBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdTif" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "TfiBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdTif
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdTif (codigos, descricaos, adendos, pqtdes, pvalors,
                    adendocs, opcsnas, oorig, oaden, ocor, oemb, otam, tamdesc, tpdescs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cAdendo)>>,
                    <<FormatarNumeroSQL(THIS.this_nPQtde, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPValor, 2)>>,
                    <<EscaparSQL(THIS.this_cAdendoCodigo)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpcaoSNA, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOOrig, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOAdendo, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOCor, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOEmb, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOTam, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTamDesc, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipoDesc, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TfiBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdTif
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdTif
                SET descricaos = <<EscaparSQL(THIS.this_cDescricao)>>,
                    adendos    = <<EscaparSQL(THIS.this_cAdendo)>>,
                    pqtdes     = <<FormatarNumeroSQL(THIS.this_nPQtde, 2)>>,
                    pvalors    = <<FormatarNumeroSQL(THIS.this_nPValor, 2)>>,
                    adendocs   = <<EscaparSQL(THIS.this_cAdendoCodigo)>>,
                    opcsnas    = <<FormatarNumeroSQL(THIS.this_nOpcaoSNA, 0)>>,
                    oorig      = <<FormatarNumeroSQL(THIS.this_nOOrig, 0)>>,
                    oaden      = <<FormatarNumeroSQL(THIS.this_nOAdendo, 0)>>,
                    ocor       = <<FormatarNumeroSQL(THIS.this_nOCor, 0)>>,
                    oemb       = <<FormatarNumeroSQL(THIS.this_nOEmb, 0)>>,
                    otam       = <<FormatarNumeroSQL(THIS.this_nOTam, 0)>>,
                    tamdesc    = <<FormatarNumeroSQL(THIS.this_nTamDesc, 0)>>,
                    tpdescs    = <<FormatarNumeroSQL(THIS.this_nTipoDesc, 0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TfiBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdTif
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdTif WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TfiBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descricaos, pqtdes, pvalors
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(3), descricaos C(40), pqtdes N(9,2), pvalors N(9,2))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descricaos, pqtdes, pvalors FROM SigCdTif"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar tipos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TfiBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, adendos, pqtdes, pvalors," + ;
                " adendocs, opcsnas, oorig, oaden, ocor, oemb, otam, tamdesc, tpdescs" + ;
                " FROM SigCdTif WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TfiBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
