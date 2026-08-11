*==============================================================================
* DupBO.prg - Business Object para Configuracao de Duplicatas
* Tabela: SigCnFDU
* PK: series
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS DupBO AS BusinessBase

    *-- Chave primaria
    this_cSeries = ""

    *-- Cabecalho - posicoes de impressao da Nota Fiscal
    this_nNlnNotas   = 0
    this_nNclNotas   = 0
    this_nNlnDtVencs = 0
    this_nNclDtVencs = 0
    this_nNlnDtDocs  = 0
    this_nNclDtDocs  = 0
    this_nNlnNrDocs  = 0
    this_nNclNrDocs  = 0
    this_nNlnVlDocs  = 0
    this_nNclVlDocs  = 0

    *-- Sacado - posicoes de impressao do cliente/cobranca
    this_nNlnRazClis = 0
    this_nNclRazClis = 0
    this_nNlnCgcClis = 0
    this_nNclCgcClis = 0
    this_nNlnEndCobs = 0
    this_nNclEndCobs = 0
    this_nNlnBaiCobs = 0
    this_nNclBaiCobs = 0
    this_nNlnCidCobs = 0
    this_nNclCidCobs = 0
    this_nNlnEstCobs = 0
    this_nNclEstCobs = 0
    this_nNlnCepCobs = 0
    this_nNclCepCobs = 0
    this_nNlnEstClis = 0
    this_nNclEstClis = 0
    this_nNlnExtens  = 0
    this_nNclExtens  = 0
    this_nNlPracas   = 0
    this_nNcPracas   = 0

    *-- Observacao - posicoes e dimensoes
    this_nNlObs     = 0
    this_nNcObs     = 0
    this_nTamColObs = 0
    this_nTamLinObs = 0

    *-- Codigo - posicao de impressao
    this_nNlnCods   = 0
    this_nNclCods   = 0

    *-- Valor NF - posicao de impressao
    this_nLNota     = 0
    this_nCNota     = 0

    *-- Impressora e fonte
    this_cNomeImps  = ""
    this_cFontePdrs = ""
    this_nTamFontes = 0
    this_cTamFolhas = ""

    *-- Auditoria
    this_dDatas    = {}
    this_cHoras    = ""
    this_cUsuarios = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCnFDU"
        THIS.this_cCampoChave = "series"
        RETURN .T.
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSeries
    ENDFUNC

    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT series FROM SigCnFDU"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE series LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY series"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cSeries)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigCnFDU WHERE series = " + EscaparSQL(par_cSeries)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSeries      = ALLTRIM(TratarNulo(series,      "C"))
            THIS.this_nNlnNotas    = TratarNulo(nlnnotas,    "N")
            THIS.this_nNclNotas    = TratarNulo(nclnotas,    "N")
            THIS.this_nNlnDtVencs  = TratarNulo(nlndtvencs,  "N")
            THIS.this_nNclDtVencs  = TratarNulo(ncldtvencs,  "N")
            THIS.this_nNlnDtDocs   = TratarNulo(nlndtdocs,   "N")
            THIS.this_nNclDtDocs   = TratarNulo(ncldtdocs,   "N")
            THIS.this_nNlnNrDocs   = TratarNulo(nlnnrdocs,   "N")
            THIS.this_nNclNrDocs   = TratarNulo(nclnrdocs,   "N")
            THIS.this_nNlnVlDocs   = TratarNulo(nlnvldocs,   "N")
            THIS.this_nNclVlDocs   = TratarNulo(nclvldocs,   "N")
            THIS.this_nNlnRazClis  = TratarNulo(nlnrazclis,  "N")
            THIS.this_nNclRazClis  = TratarNulo(nclrazclis,  "N")
            THIS.this_nNlnCgcClis  = TratarNulo(nlncgcclis,  "N")
            THIS.this_nNclCgcClis  = TratarNulo(nclcgcclis,  "N")
            THIS.this_nNlnEndCobs  = TratarNulo(nlnendcobs,  "N")
            THIS.this_nNclEndCobs  = TratarNulo(nclendcobs,  "N")
            THIS.this_nNlnBaiCobs  = TratarNulo(nlnbaicobs,  "N")
            THIS.this_nNclBaiCobs  = TratarNulo(nclbaicobs,  "N")
            THIS.this_nNlnCidCobs  = TratarNulo(nlncidcobs,  "N")
            THIS.this_nNclCidCobs  = TratarNulo(nclcidcobs,  "N")
            THIS.this_nNlnEstCobs  = TratarNulo(nlnestcobs,  "N")
            THIS.this_nNclEstCobs  = TratarNulo(nclestcobs,  "N")
            THIS.this_nNlnCepCobs  = TratarNulo(nlncepcobs,  "N")
            THIS.this_nNclCepCobs  = TratarNulo(nclcepcobs,  "N")
            THIS.this_nNlnEstClis  = TratarNulo(nlnestclis,  "N")
            THIS.this_nNclEstClis  = TratarNulo(nclestclis,  "N")
            THIS.this_nNlnExtens   = TratarNulo(nlnextens,   "N")
            THIS.this_nNclExtens   = TratarNulo(nclextens,   "N")
            THIS.this_nNlPracas    = TratarNulo(nlpracas,    "N")
            THIS.this_nNcPracas    = TratarNulo(ncpracas,    "N")
            THIS.this_nNlObs       = TratarNulo(nlobs,       "N")
            THIS.this_nNcObs       = TratarNulo(ncobs,       "N")
            THIS.this_nTamColObs   = TratarNulo(tamcolobs,   "N")
            THIS.this_nTamLinObs   = TratarNulo(tamlinobs,   "N")
            THIS.this_nNlnCods     = TratarNulo(nlncods,     "N")
            THIS.this_nNclCods     = TratarNulo(nclcods,     "N")
            THIS.this_nLNota       = TratarNulo(lnota,       "N")
            THIS.this_nCNota       = TratarNulo(cnota,       "N")
            THIS.this_cNomeImps    = ALLTRIM(TratarNulo(cnomeimps,    "C"))
            THIS.this_cFontePdrs   = ALLTRIM(TratarNulo(cfontepdrs,   "C"))
            THIS.this_nTamFontes   = TratarNulo(ntamfontes,   "N")
            THIS.this_cTamFolhas   = ALLTRIM(TratarNulo(ctamfolhas,   "C"))
            THIS.this_cHoras       = ALLTRIM(TratarNulo(choras,       "C"))
            THIS.this_cUsuarios    = ALLTRIM(TratarNulo(cusuarios,    "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCnFDU (" + ;
                "series, cemps, cnomeimps, cfontepdrs, ntamfontes, ctamfolhas," + ;
                " cusuarios, ddatas, choras, clocals," + ;
                " nlnnotas, nclnotas, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlnrazclis, nclrazclis," + ;
                " nlncgcclis, nclcgcclis, nlnendcobs, nclendcobs," + ;
                " nlnbaicobs, nclbaicobs, nlncidcobs, nclcidcobs," + ;
                " nlnestcobs, nclestcobs, nlncepcobs, nclcepcobs," + ;
                " nlnestclis, nclestclis, nlnextens, nclextens," + ;
                " nlpracas, ncpracas, nlobs, ncobs," + ;
                " tamcolobs, tamlinobs, nlncods, nclcods, lnota, cnota" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cSeries) + ", " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cNomeImps,  128)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamFontes) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTamFolhas,  80)) + ", " + ;
                EscaparSQL(LEFT(gc_4c_UsuarioLogado,   20)) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(TIME()) + ", " + ;
                EscaparSQL("") + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnNotas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclNotas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnDtVencs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclDtVencs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnDtDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclDtDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnNrDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclNrDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnVlDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclVlDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnRazClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclRazClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCgcClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCgcClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEndCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEndCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclBaiCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCidCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCidCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEstCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEstCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCepCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCepCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEstClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEstClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnExtens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclExtens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlPracas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcPracas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlObs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcObs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamColObs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamLinObs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCods)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCods)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLNota)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nCNota)      + ;
                ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Insert")
                TABLEREVERT(.T., "cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCnFDU SET " + ;
                "cnomeimps  = " + EscaparSQL(LEFT(THIS.this_cNomeImps,  128)) + ", " + ;
                "cfontepdrs = " + EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + ", " + ;
                "ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamFontes) + ", " + ;
                "ctamfolhas = " + EscaparSQL(LEFT(THIS.this_cTamFolhas,  80)) + ", " + ;
                "cusuarios  = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado,   20)) + ", " + ;
                "ddatas = GETDATE(), " + ;
                "choras = " + EscaparSQL(TIME()) + ", " + ;
                "nlnnotas   = " + FormatarNumeroSQL(THIS.this_nNlnNotas)   + ", " + ;
                "nclnotas   = " + FormatarNumeroSQL(THIS.this_nNclNotas)   + ", " + ;
                "nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + ", " + ;
                "ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + ", " + ;
                "nlndtdocs  = " + FormatarNumeroSQL(THIS.this_nNlnDtDocs)  + ", " + ;
                "ncldtdocs  = " + FormatarNumeroSQL(THIS.this_nNclDtDocs)  + ", " + ;
                "nlnnrdocs  = " + FormatarNumeroSQL(THIS.this_nNlnNrDocs)  + ", " + ;
                "nclnrdocs  = " + FormatarNumeroSQL(THIS.this_nNclNrDocs)  + ", " + ;
                "nlnvldocs  = " + FormatarNumeroSQL(THIS.this_nNlnVlDocs)  + ", " + ;
                "nclvldocs  = " + FormatarNumeroSQL(THIS.this_nNclVlDocs)  + ", " + ;
                "nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + ", " + ;
                "nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclRazClis) + ", " + ;
                "nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + ", " + ;
                "nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + ", " + ;
                "nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + ", " + ;
                "nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + ", " + ;
                "nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + ", " + ;
                "nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + ", " + ;
                "nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + ", " + ;
                "nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + ", " + ;
                "nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + ", " + ;
                "nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + ", " + ;
                "nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + ", " + ;
                "nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + ", " + ;
                "nlnestclis = " + FormatarNumeroSQL(THIS.this_nNlnEstClis) + ", " + ;
                "nclestclis = " + FormatarNumeroSQL(THIS.this_nNclEstClis) + ", " + ;
                "nlnextens  = " + FormatarNumeroSQL(THIS.this_nNlnExtens)  + ", " + ;
                "nclextens  = " + FormatarNumeroSQL(THIS.this_nNclExtens)  + ", " + ;
                "nlpracas   = " + FormatarNumeroSQL(THIS.this_nNlPracas)   + ", " + ;
                "ncpracas   = " + FormatarNumeroSQL(THIS.this_nNcPracas)   + ", " + ;
                "nlobs      = " + FormatarNumeroSQL(THIS.this_nNlObs)      + ", " + ;
                "ncobs      = " + FormatarNumeroSQL(THIS.this_nNcObs)      + ", " + ;
                "tamcolobs  = " + FormatarNumeroSQL(THIS.this_nTamColObs)  + ", " + ;
                "tamlinobs  = " + FormatarNumeroSQL(THIS.this_nTamLinObs)  + ", " + ;
                "nlncods    = " + FormatarNumeroSQL(THIS.this_nNlnCods)    + ", " + ;
                "nclcods    = " + FormatarNumeroSQL(THIS.this_nNclCods)    + ", " + ;
                "lnota      = " + FormatarNumeroSQL(THIS.this_nLNota)      + ", " + ;
                "cnota      = " + FormatarNumeroSQL(THIS.this_nCNota)      + ;
                " WHERE series = " + EscaparSQL(THIS.this_cSeries)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Update")
                TABLEREVERT(.T., "cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCnFDU WHERE series = " + EscaparSQL(THIS.this_cSeries)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Delete")
                TABLEREVERT(.T., "cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
