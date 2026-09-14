*------------------------------------------------------------------------------
* OccBO.prg - Business Object para Ocorrencias de Correcao
* Tabela: SigCcOco
* Herda de: BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS OccBO AS BusinessBase

    *-- Propriedades da entidade SigCcOco
    this_nCodigo    = 0   && ncodigos numeric(3,0) - Chave primaria
    this_cDescricao = ""  && cdescrs  char(30)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCcOco"
            THIS.this_cCampoChave = "ncodigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodigo    = TratarNulo(ncodigos, "N")
            THIS.this_cDescricao = TratarNulo(cdescrs,  "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona registros com filtro opcional
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                       " FROM SigCcOco" + ;
                       " ORDER BY ncodigos"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                           " FROM SigCcOco" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY ncodigos"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro especifico pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_nCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                       " FROM SigCcOco" + ;
                       " WHERE ncodigos = " + FormatarNumeroSQL(par_nCodigo, 0)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Codigo obrigatorio
            IF THIS.this_nCodigo <= 0
                MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Descricao obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cDescricao))
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar duplicidade no INSERT
            IF THIS.this_lNovoRegistro
                loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCcOco" + ;
                           " WHERE ncodigos = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkDup")
                    TABLEREVERT(.T., "cursor_4c_ChkDup")
                    USE IN cursor_4c_ChkDup
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_ChkDup
                    IF cursor_4c_ChkDup.Total > 0
                        MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
                        USE IN cursor_4c_ChkDup
                        loc_lSucesso = .F.
                    ENDIF
                    USE IN cursor_4c_ChkDup
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCcOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCcOco (ncodigos, cdescrs)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCcOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCcOco" + ;
                       " SET cdescrs = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE ncodigos = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro (PROTECTED)
    * Verifica referencia em SigNfCor.noccors antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.
        TRY
            *-- Verificar referencia em SigNfCor antes de excluir
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigNfCor" + ;
                       " WHERE noccors = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkRef")
                TABLEREVERT(.T., "cursor_4c_ChkRef")
                USE IN cursor_4c_ChkRef
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkRef")

            IF loc_nResultado >= 0
                SELECT cursor_4c_ChkRef
                IF cursor_4c_ChkRef.Total > 0
                    MsgAviso("Ocorr" + CHR(234) + "ncia com Movimenta" + CHR(231) + CHR(227) + "o, " + ;
                             "Exclus" + CHR(227) + "o Inv" + CHR(225) + "lida!", "")
                    USE IN cursor_4c_ChkRef
                    loc_lSucesso = .F.
                ENDIF
                USE IN cursor_4c_ChkRef
            ENDIF

            loc_cSQL = "DELETE FROM SigCcOco" + ;
                       " WHERE ncodigos = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
