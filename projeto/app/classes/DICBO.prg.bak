*==============================================================================
* DICBO.prg - Business Object para Dicionario de Idiomas
* Tabela: SigCdDic
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DICBO AS BusinessBase

    *-- Campos da tabela SigCdDic
    this_dDatas     = {}    && datas datetime NULL
    this_cExpressao = ""    && expressao char(60) NOT NULL
    this_cIdioma    = ""    && idioma char(10) NOT NULL
    this_cTraducao  = ""    && traducao char(60) NOT NULL
    this_cUsuars    = ""    && usuars char(10) NOT NULL

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDic"
            THIS.this_cCampoChave = "Expressao"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cExpressao) + "|" + ALLTRIM(THIS.this_cIdioma)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros do dicionario filtrados por par_cFiltro
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Idioma, Expressao, Traducao" + ;
                    " FROM SigCdDic" + ;
                    " ORDER BY Expressao, Idioma"
            ELSE
                loc_cSQL = "SELECT Idioma, Expressao, Traducao" + ;
                    " FROM SigCdDic" + ;
                    " WHERE Expressao LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    "    OR Idioma LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY Expressao, Idioma"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave composta Expressao + Idioma
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cExpressao, par_cIdioma)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT datas, expressao, idioma, traducao, usuars" + ;
                " FROM SigCdDic" + ;
                " WHERE Expressao = " + EscaparSQL(par_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(par_cIdioma)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_dDatas     = TratarNulo(datas,      "D")
            THIS.this_cExpressao = TratarNulo(expressao,  "C")
            THIS.this_cIdioma    = TratarNulo(idioma,     "C")
            THIS.this_cTraducao  = TratarNulo(traducao,   "C")
            THIS.this_cUsuars    = TratarNulo(usuars,     "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de inserir/atualizar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cExpressao))
            MsgAviso("Express" + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cIdioma))
            MsgAviso("Idioma Inv" + CHR(225) + "lido !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cTraducao))
            MsgAviso("Tradu" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se Expressao+Idioma ja existe (apenas no INSERT)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDic" + ;
                " WHERE Expressao = " + EscaparSQL(THIS.this_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(THIS.this_cIdioma)

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.Total > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            IF THIS.VerificarDuplicidade()
                MsgAviso(CHR(67) + CHR(243) + "digo j" + CHR(225) + " Cadastrado !!", "Duplicado")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdDic" + ;
                    " (datas, expressao, idioma, traducao, usuars)" + ;
                    " VALUES (" + ;
                    "GETDATE(), " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cExpressao), 60)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cIdioma), 10)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cTraducao), 60)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuars), 10)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE SigCdDic SET" + ;
                " traducao = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTraducao), 60)) + "," + ;
                " usuars   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuars), 10)) + ;
                " WHERE Expressao = " + EscaparSQL(THIS.this_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(THIS.this_cIdioma)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDic" + ;
                " WHERE Expressao = " + EscaparSQL(THIS.this_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(THIS.this_cIdioma)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
