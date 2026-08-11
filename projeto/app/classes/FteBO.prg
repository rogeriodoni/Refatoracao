*==============================================================================
* FteBO.prg - Business Object para Fichas Tecnicas
* Tabela: SigCdFtr
* PK: cIdChaves
*==============================================================================
DEFINE CLASS FteBO AS BusinessBase

    *-- Chave primaria
    this_cIdChaves    = ""

    *-- Campos de contexto (filtro/PK composta)
    this_cCGrus       = ""    && CGrus - Grupo
    this_cSGrus       = ""    && SGrus - SubGrupo
    this_cCCars       = ""    && CCars - Cargo
    this_cCTits       = ""    && CTits - Titulo
    this_cGruCarTits  = ""    && GruCarTits - Chave composta (CGrus+CCars+CTits+SGrus)

    *-- Campos de conteudo
    this_cResps       = ""    && Resps - Texto da resposta (memo)
    this_nNResps      = 0     && nResps - Resposta Fixa (0=Nao, 1=Sim)

    *-- Contexto de abertura (parametros recebidos pelo form)
    this_cContextGrupos  = ""
    this_cContextSubGrp  = ""
    this_cContextCargos  = ""
    this_cContextTitulos = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdFtr"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT filtrado pelo contexto (GruCarTits = CGrus+CCars+CTits+SGrus)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cChave, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.this_cContextGrupos + THIS.this_cContextCargos + ;
                         THIS.this_cContextTitulos + THIS.this_cContextSubGrp

            loc_cSQL = "SELECT cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits," + ;
                       " Resps, nResps" + ;
                       " FROM SigCdFtr" + ;
                       " WHERE GruCarTits = " + EscaparSQL(loc_cChave)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cIdChaves"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar fichas t" + CHR(233) + "cnicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por PK (cIdChaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits," + ;
                       " Resps, nResps" + ;
                       " FROM SigCdFtr" + ;
                       " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves   = TratarNulo(cIdChaves,   "C")
            THIS.this_cCGrus      = TratarNulo(CGrus,        "C")
            THIS.this_cSGrus      = TratarNulo(SGrus,        "C")
            THIS.this_cCCars      = TratarNulo(CCars,        "C")
            THIS.this_cCTits      = TratarNulo(CTits,        "C")
            THIS.this_cGruCarTits = TratarNulo(GruCarTits,   "C")
            THIS.this_cResps      = TratarNulo(Resps,        "C")
            THIS.this_nNResps     = TratarNulo(nResps,       "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_cNovaChave, loc_nResId, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = ""
            loc_nResId = SQLEXEC(gnConnHandle, "SELECT CONVERT(varchar(36), NEWID()) AS NovaChave", "cursor_4c_NewId")
            IF loc_nResId >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                loc_cNovaChave = ALLTRIM(cursor_4c_NewId.NovaChave)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF

            IF EMPTY(loc_cNovaChave)
                MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ELSE
                THIS.this_cIdChaves   = loc_cNovaChave
                THIS.this_cGruCarTits = THIS.this_cCGrus + THIS.this_cCCars + ;
                                        THIS.this_cCTits + THIS.this_cSGrus

                loc_cSQL = "INSERT INTO SigCdFtr" + ;
                           " (cIdChaves, CGrus, SGrus, CCars, CTits, GruCarTits, Resps, nResps)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cIdChaves)   + ", " + ;
                           EscaparSQL(THIS.this_cCGrus)      + ", " + ;
                           EscaparSQL(THIS.this_cSGrus)      + ", " + ;
                           EscaparSQL(THIS.this_cCCars)      + ", " + ;
                           EscaparSQL(THIS.this_cCTits)      + ", " + ;
                           EscaparSQL(THIS.this_cGruCarTits) + ", " + ;
                           EscaparSQL(THIS.this_cResps)      + ", " + ;
                           FormatarNumeroSQL(THIS.this_nNResps) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cGruCarTits = THIS.this_cCGrus + THIS.this_cCCars + ;
                                    THIS.this_cCTits + THIS.this_cSGrus

            loc_cSQL = "UPDATE SigCdFtr SET" + ;
                       " CGrus = "      + EscaparSQL(THIS.this_cCGrus)      + "," + ;
                       " SGrus = "      + EscaparSQL(THIS.this_cSGrus)      + "," + ;
                       " CCars = "      + EscaparSQL(THIS.this_cCCars)      + "," + ;
                       " CTits = "      + EscaparSQL(THIS.this_cCTits)      + "," + ;
                       " GruCarTits = " + EscaparSQL(THIS.this_cGruCarTits) + "," + ;
                       " Resps = "      + EscaparSQL(THIS.this_cResps)      + "," + ;
                       " nResps = "     + FormatarNumeroSQL(THIS.this_nNResps) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdFtr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFtr" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
