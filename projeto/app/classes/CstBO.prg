*==============================================================================
* CstBO.prg - Business Object para Constantes
* Tabela: SigCdCnt
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS CstBO AS BusinessBase

    *-- Propriedades da tabela SigCdCnt
    this_cCodigo    = ""    && Codigos     C(3)  - PK
    this_cDescricao = ""    && Descricaos  C(40)
    this_nConstante = 0     && Consts      N(13,6) - Valor da Constante
    this_cMoeda     = ""    && Moedas      C(3)  - FK SigCdMoe.Cmoes

    *-- Propriedade auxiliar de exibicao (nao persistida em SigCdCnt)
    this_cDescMoeda = ""    && SigCdMoe.Dmoes C(15) - Descricao da Moeda

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCnt"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "CstBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
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
                THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                THIS.this_nConstante = TratarNulo(consts,     "N")
                THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CstBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo da Constante j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cMoeda)
            MsgAviso("Moeda n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigCdCnt" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (NVL(cursor_4c_ChkCod.nTotal, 0) > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CstBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCnt (codigos, descricaos, consts, moedas)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    <<EscaparSQL(THIS.this_cMoeda)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CstBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCnt
                SET descricaos = <<EscaparSQL(THIS.this_cDescricao)>>,
                    consts     = <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    moedas     = <<EscaparSQL(THIS.this_cMoeda)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CstBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCnt
    * Valida uso em SigOpTdt (6 campos de constante) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se constante esta sendo usada em operacoes (SigOpTdt)
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigOpTdt" + ;
                " WHERE (const1t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const1t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t2s = " + EscaparSQL(THIS.this_cCodigo) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCnt")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkCnt")
                    SELECT cursor_4c_ChkCnt
                    loc_nUso = NVL(cursor_4c_ChkCnt.nTotal, 0)
                    USE IN cursor_4c_ChkCnt
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("Constante sendo utilizada em Opera" + CHR(231) + CHR(245) + "es!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCnt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CstBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor crSigCdCnt com codigos, descricaos, consts, moedas
    * (cursor nomeado igual ao legado para compatibilidade com grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("crSigCdCnt")
                    SET NULL ON
                    CREATE CURSOR crSigCdCnt (codigos C(3), descricaos C(40), consts N(13,6), moedas C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas" + ;
                    " FROM SigCdCnt a"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

                IF USED("crSigCdCnt")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT crSigCdCnt
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnt")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CstBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    * Tambem carrega descricao da moeda via JOIN com SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas," + ;
                " b.dmoes AS descmoes" + ;
                " FROM SigCdCnt a" + ;
                " LEFT JOIN SigCdMoe b ON b.cmoes = a.moedas" + ;
                " WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    SELECT cursor_4c_Carrega
                    THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                    THIS.this_cDescricao = TratarNulo(descricaos, "C")
                    THIS.this_nConstante = TratarNulo(consts,     "N")
                    THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                    THIS.this_cDescMoeda = TratarNulo(descmoes,   "C")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Constante n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CstBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescMoeda - Carrega descricao da moeda pelo codigo
    * Usado apos lookup de moeda para atualizar campo de exibicao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescMoeda(par_cCodigoMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cCodigoMoeda)
                THIS.this_cDescMoeda = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.dmoes FROM SigCdMoe a" + ;
                    " WHERE a.cmoes = " + EscaparSQL(par_cCodigoMoeda)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe")

                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_Moe") > 0
                        SELECT cursor_4c_Moe
                        THIS.this_cDescMoeda = TratarNulo(dmoes, "C")
                    ELSE
                        THIS.this_cDescMoeda = ""
                    ENDIF

                    IF USED("cursor_4c_Moe")
                        USE IN cursor_4c_Moe
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao carregar moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da moeda:" + CHR(13) + loException.Message, "CstBO.CarregarDescMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
