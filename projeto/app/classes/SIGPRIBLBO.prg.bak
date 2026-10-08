*====================================================================
* SIGPRIBLBO.prg
*
* Business Object para Impressao de Boleto Bancario (form OPERACIONAL)
* Tabela: SigCnFBl (Configuracao de Impressao de Boleto Bancario)
* Chave: cidchaves char(20) - PK
* Busca: fpags char(12) - Condicao de Pagamento (campo digitado na tela)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRIBLBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCnFBl)
    this_cIdChaves  = ""    && cidchaves char(20) - PK
    this_cFPags     = ""    && fpags char(12) - condicao de pagamento (chave de busca)
    this_cEmps      = ""    && cemps char(3)
    this_dDatas     = {}    && ddatas datetime
    this_cHoras     = ""    && choras char(8)
    this_cUsuarios  = ""    && cusuarios char(20)
    this_cTxtCds    = ""    && ctxtcds text - texto de responsabilidade do cedente
    this_cLocals    = ""    && clocals char(100) - local de pagamento
    this_nLnLocals  = 0     && nlnlocals numeric(5,2)
    this_nClLocals  = 0     && ncllocals numeric(5,2)
    this_nLnDtVencs = 0     && nlndtvencs numeric(5,2)
    this_nClDtVencs = 0     && ncldtvencs numeric(5,2)
    this_nLnDtDocs  = 0     && nlndtdocs numeric(5,2)
    this_nClDtDocs  = 0     && ncldtdocs numeric(5,2)
    this_nLnNrDocs  = 0     && nlnnrdocs numeric(5,2)
    this_nClNrDocs  = 0     && nclnrdocs numeric(5,2)
    this_nLnVlDocs  = 0     && nlnvldocs numeric(5,2)
    this_nClVlDocs  = 0     && nclvldocs numeric(5,2)
    this_nLnTxtCds  = 0     && nlntxtcds numeric(5,2)
    this_nClTxtCds  = 0     && ncltxtcds numeric(5,2)
    this_nTxtLins   = 0     && ntxtlins numeric(3,0)
    this_nTxtCols   = 0     && ntxtcols numeric(3,0)
    this_nLnRazClis = 0     && nlnrazclis numeric(5,2)
    this_nClRazClis = 0     && nclrazclis numeric(5,2)
    this_nLnEndCobs = 0     && nlnendcobs numeric(5,2)
    this_nClEndCobs = 0     && nclendcobs numeric(5,2)
    this_nLnCgcClis = 0     && nlncgcclis numeric(5,2)
    this_nClCgcClis = 0     && nclcgcclis numeric(5,2)
    this_nLnBaiCobs = 0     && nlnbaicobs numeric(5,2)
    this_nClBaiCobs = 0     && nclbaicobs numeric(5,2)
    this_nLnCidCobs = 0     && nlncidcobs numeric(5,2)
    this_nClCidCobs = 0     && nclcidcobs numeric(5,2)
    this_nLnEstCobs = 0     && nlnestcobs numeric(5,2)
    this_nClEstCobs = 0     && nclestcobs numeric(5,2)
    this_nLnCepCobs = 0     && nlncepcobs numeric(5,2)
    this_nClCepCobs = 0     && nclcepcobs numeric(5,2)
    this_cNomeImps  = ""    && cnomeimps char(128) - nome da impressora
    this_cFontePdrs = ""    && cfontepdrs char(128) - fonte padrao
    this_nTamFontes = 0     && ntamfontes numeric(3,0)
    this_cTamFolha  = ""    && ctamfolha char(50)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCnFBl"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGPRIBLBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cidchaves eh a PK fisica (char(20)) de SigCnFBl
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia todas as colunas do cursor para as propriedades
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves,  "")
            THIS.this_cFPags     = TratarNulo(fpags,      "")
            THIS.this_cEmps      = TratarNulo(cemps,      "")
            THIS.this_dDatas     = TratarNulo(ddatas,     {})
            THIS.this_cHoras     = TratarNulo(choras,     "")
            THIS.this_cUsuarios  = TratarNulo(cusuarios,  "")
            THIS.this_cTxtCds    = TratarNulo(ctxtcds,    "")
            THIS.this_cLocals    = TratarNulo(clocals,    "")
            THIS.this_nLnLocals  = TratarNulo(nlnlocals,  0)
            THIS.this_nClLocals  = TratarNulo(ncllocals,  0)
            THIS.this_nLnDtVencs = TratarNulo(nlndtvencs, 0)
            THIS.this_nClDtVencs = TratarNulo(ncldtvencs, 0)
            THIS.this_nLnDtDocs  = TratarNulo(nlndtdocs,  0)
            THIS.this_nClDtDocs  = TratarNulo(ncldtdocs,  0)
            THIS.this_nLnNrDocs  = TratarNulo(nlnnrdocs,  0)
            THIS.this_nClNrDocs  = TratarNulo(nclnrdocs,  0)
            THIS.this_nLnVlDocs  = TratarNulo(nlnvldocs,  0)
            THIS.this_nClVlDocs  = TratarNulo(nclvldocs,  0)
            THIS.this_nLnTxtCds  = TratarNulo(nlntxtcds,  0)
            THIS.this_nClTxtCds  = TratarNulo(ncltxtcds,  0)
            THIS.this_nTxtLins   = TratarNulo(ntxtlins,   0)
            THIS.this_nTxtCols   = TratarNulo(ntxtcols,   0)
            THIS.this_nLnRazClis = TratarNulo(nlnrazclis, 0)
            THIS.this_nClRazClis = TratarNulo(nclrazclis, 0)
            THIS.this_nLnEndCobs = TratarNulo(nlnendcobs, 0)
            THIS.this_nClEndCobs = TratarNulo(nclendcobs, 0)
            THIS.this_nLnCgcClis = TratarNulo(nlncgcclis, 0)
            THIS.this_nClCgcClis = TratarNulo(nclcgcclis, 0)
            THIS.this_nLnBaiCobs = TratarNulo(nlnbaicobs, 0)
            THIS.this_nClBaiCobs = TratarNulo(nclbaicobs, 0)
            THIS.this_nLnCidCobs = TratarNulo(nlncidcobs, 0)
            THIS.this_nClCidCobs = TratarNulo(nclcidcobs, 0)
            THIS.this_nLnEstCobs = TratarNulo(nlnestcobs, 0)
            THIS.this_nClEstCobs = TratarNulo(nclestcobs, 0)
            THIS.this_nLnCepCobs = TratarNulo(nlncepcobs, 0)
            THIS.this_nClCepCobs = TratarNulo(nclcepcobs, 0)
            THIS.this_cNomeImps  = TratarNulo(cnomeimps,  "")
            THIS.this_cFontePdrs = TratarNulo(cfontepdrs, "")
            THIS.this_nTamFontes = TratarNulo(ntamfontes, 0)
            THIS.this_cTamFolha  = TratarNulo(ctamfolha,  "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorFPags - Carrega configuracao de boleto pela condicao de
    * pagamento (fpags eh o campo de busca digitado na tela; cidchaves eh a
    * PK fisica Fortyus, gerada so no Inserir)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorFPags(par_cFPags)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                       " ctxtcds, clocals, nlnlocals, ncllocals," + ;
                       " nlndtvencs, ncldtvencs, nlndtdocs, ncldtdocs," + ;
                       " nlnnrdocs, nclnrdocs, nlnvldocs, nclvldocs," + ;
                       " nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                       " nlnrazclis, nclrazclis, nlnendcobs, nclendcobs," + ;
                       " nlncgcclis, nclcgcclis, nlnbaicobs, nclbaicobs," + ;
                       " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                       " nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs," + ;
                       " ntamfontes, ctamfolha" + ;
                       " FROM SigCnFBl WHERE fpags = " + EscaparSQL(par_cFPags)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT completo na tabela SigCnFBl
    * cidchaves eh a PK fisica Fortyus - gerada aqui, nunca vazia (regra #22)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChaves = PADR(fUniqueIds(), 20)

            loc_cSQL = "INSERT INTO SigCnFBl" + ;
                       " (cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                       " ctxtcds, clocals, nlnlocals, ncllocals," + ;
                       " nlndtvencs, ncldtvencs, nlndtdocs, ncldtdocs," + ;
                       " nlnnrdocs, nclnrdocs, nlnvldocs, nclvldocs," + ;
                       " nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                       " nlnrazclis, nclrazclis, nlnendcobs, nclendcobs," + ;
                       " nlncgcclis, nclcgcclis, nlnbaicobs, nclbaicobs," + ;
                       " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                       " nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs," + ;
                       " ntamfontes, ctamfolha)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cFPags, 12)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cHoras, 8)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cUsuarios, 20)) + "," + ;
                       EscaparSQL(THIS.this_cTxtCds) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cLocals, 100)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnLocals, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClLocals, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTxtLins, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTxtCols, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClRazClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cNomeImps, 128)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTamFontes, 0) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cTamFolha, 50)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE completo na tabela SigCnFBl (cidchaves eh a chave,
    * nunca alterada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " fpags = "      + EscaparSQL(LEFT(THIS.this_cFPags, 12)) + "," + ;
                       " cemps = "      + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
                       " ddatas = "     + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " choras = "     + EscaparSQL(LEFT(THIS.this_cHoras, 8)) + "," + ;
                       " cusuarios = "  + EscaparSQL(LEFT(THIS.this_cUsuarios, 20)) + "," + ;
                       " ctxtcds = "    + EscaparSQL(THIS.this_cTxtCds) + "," + ;
                       " clocals = "    + EscaparSQL(LEFT(THIS.this_cLocals, 100)) + "," + ;
                       " nlnlocals = "  + FormatarNumeroSQL(THIS.this_nLnLocals, 2) + "," + ;
                       " ncllocals = "  + FormatarNumeroSQL(THIS.this_nClLocals, 2) + "," + ;
                       " nlndtvencs = " + FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + "," + ;
                       " ncldtvencs = " + FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + "," + ;
                       " nlndtdocs = "  + FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + "," + ;
                       " ncldtdocs = "  + FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + "," + ;
                       " nlnnrdocs = "  + FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + "," + ;
                       " nclnrdocs = "  + FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + "," + ;
                       " nlnvldocs = "  + FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + "," + ;
                       " nclvldocs = "  + FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + "," + ;
                       " nlntxtcds = "  + FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + "," + ;
                       " ncltxtcds = "  + FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + "," + ;
                       " ntxtlins = "   + FormatarNumeroSQL(THIS.this_nTxtLins, 0) + "," + ;
                       " ntxtcols = "   + FormatarNumeroSQL(THIS.this_nTxtCols, 0) + "," + ;
                       " nlnrazclis = " + FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + "," + ;
                       " nclrazclis = " + FormatarNumeroSQL(THIS.this_nClRazClis, 2) + "," + ;
                       " nlnendcobs = " + FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + "," + ;
                       " nclendcobs = " + FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + "," + ;
                       " nlncgcclis = " + FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + "," + ;
                       " nclcgcclis = " + FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + "," + ;
                       " nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + "," + ;
                       " nclbaicobs = " + FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + "," + ;
                       " nlncidcobs = " + FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + "," + ;
                       " nclcidcobs = " + FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + "," + ;
                       " nlnestcobs = " + FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + "," + ;
                       " nclestcobs = " + FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + "," + ;
                       " nlncepcobs = " + FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + "," + ;
                       " nclcepcobs = " + FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + "," + ;
                       " cnomeimps = "  + EscaparSQL(LEFT(THIS.this_cNomeImps, 128)) + "," + ;
                       " cfontepdrs = " + EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + "," + ;
                       " ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamFontes, 0) + "," + ;
                       " ctamfolha = "  + EscaparSQL(LEFT(THIS.this_cTamFolha, 50)) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
