*==============================================================================
* CfbBO.prg - Business Object: Configura??o de Boletos Banc?rios
* Tabela: SIGCNFBL
* PK: cidchaves (t?cnica) | Chave de neg?cio: fpags (FK SigOpFp)
*==============================================================================
DEFINE CLASS CfbBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chaves
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && cidchaves char(20) - PK t?cnica
    this_cFPags     = ""    && fpags     char(12) - chave de neg?cio (FK SigOpFp)

    *--------------------------------------------------------------------------
    * Propriedades - Audi/Controle
    *--------------------------------------------------------------------------
    this_cCEmps     = ""    && cemps      char(3)
    this_dDDatas    = {}    && ddatas     datetime
    this_cCHoras    = ""    && choras     char(8)
    this_cCUsuarios = ""    && cusuarios  char(20)

    *--------------------------------------------------------------------------
    * Propriedades - Texto livre (sem binding UI, preservado na grava??o)
    *--------------------------------------------------------------------------
    this_cCLocals   = ""    && clocals    char(100) - local de pagamento (texto)
    this_cCTxtCds   = ""    && ctxtcds    text      - texto de resp. do cedente

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Cabe?alho (Local de Pagamento)
    *--------------------------------------------------------------------------
    this_nNlnLocals = 0     && nlnlocals  numeric(5,2) - linha
    this_nNclLocals = 0     && ncllocals  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Vencimento
    *--------------------------------------------------------------------------
    this_nNlnDtVencs = 0    && nlndtvencs numeric(5,2) - linha
    this_nNclDtVencs = 0    && ncldtvencs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Data Documento
    *--------------------------------------------------------------------------
    this_nNlnDtDocs = 0     && nlndtdocs  numeric(5,2) - linha
    this_nNclDtDocs = 0     && ncldtdocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o N? do Documento
    *--------------------------------------------------------------------------
    this_nNlnNrDocs = 0     && nlnnrdocs  numeric(5,2) - linha
    this_nNclNrDocs = 0     && nclnrdocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Valor do Documento
    *--------------------------------------------------------------------------
    this_nNlnVlDocs = 0     && nlnvldocs  numeric(5,2) - linha
    this_nNclVlDocs = 0     && nclvldocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Texto de Responsabilidade
    *--------------------------------------------------------------------------
    this_nNlnTxtCds = 0     && nlntxtcds  numeric(5,2) - linha
    this_nNclTxtCds = 0     && ncltxtcds  numeric(5,2) - coluna
    this_nNTxtLins  = 0     && ntxtlins   numeric(3,0) - n? de linhas
    this_nNTxtCols  = 0     && ntxtcols   numeric(3,0) - n? de colunas

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Raz?o Social
    *--------------------------------------------------------------------------
    this_nNlnRazClis = 0    && nlnrazclis numeric(5,2) - linha
    this_nNclRazClis = 0    && nclrazclis numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: C.G.C./C.P.F.
    *--------------------------------------------------------------------------
    this_nNlnCgcClis = 0    && nlncgcclis numeric(5,2) - linha
    this_nNclCgcClis = 0    && nclcgcclis numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Endere?o
    *--------------------------------------------------------------------------
    this_nNlnEndCobs = 0    && nlnendcobs numeric(5,2) - linha
    this_nNclEndCobs = 0    && nclendcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Bairro
    *--------------------------------------------------------------------------
    this_nNlnBaiCobs = 0    && nlnbaicobs numeric(5,2) - linha
    this_nNclBaiCobs = 0    && nclbaicobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Cidade
    *--------------------------------------------------------------------------
    this_nNlnCidCobs = 0    && nlncidcobs numeric(5,2) - linha
    this_nNclCidCobs = 0    && nclcidcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: U.F.
    *--------------------------------------------------------------------------
    this_nNlnEstCobs = 0    && nlnestcobs numeric(5,2) - linha
    this_nNclEstCobs = 0    && nclestcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: C.E.P.
    *--------------------------------------------------------------------------
    this_nNlnCepCobs = 0    && nlncepcobs numeric(5,2) - linha
    this_nNclCepCobs = 0    && nclcepcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Impressora / Fonte
    *--------------------------------------------------------------------------
    this_cCNomeImps  = ""   && cnomeimps  char(128) - nome da impressora
    this_cCFontePdrs = ""   && cfontepdrs char(128) - fonte padr?o
    this_nNTamFontes = 0    && ntamfontes numeric(3,0) - tamanho da fonte
    this_cCTamFolha  = ""   && ctamfolha  char(50)  - tamanho da folha

    *--------------------------------------------------------------------------
    * Propriedades auxiliares (display only, n?o persistidas em SIGCNFBL)
    *--------------------------------------------------------------------------
    this_cDescrs = ""       && Descrs de SigOpFp (descri??o da condi??o de pgto)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SIGCNFBL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * Buscar - Lista condi??es de pagamento com indicador de configura??o
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT DISTINCT a.FPags, a.Descrs," + ;
                    " b.FPags AS TemDados" + ;
                    " FROM SigOpFp a" + ;
                    " LEFT JOIN SIGCNFBL b ON a.FPags = b.FPags" + ;
                    " ORDER BY a.FPags"
            ELSE
                loc_cSQL = "SELECT DISTINCT a.FPags, a.Descrs," + ;
                    " b.FPags AS TemDados" + ;
                    " FROM SigOpFp a" + ;
                    " LEFT JOIN SIGCNFBL b ON a.FPags = b.FPags" + ;
                    " WHERE a.FPags = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                    " ORDER BY a.FPags"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar condi" + CHR(231) + CHR(245) + "es de pagamento:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar condi" + CHR(231) + CHR(245) + "es de pagamento:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega configura??o de boleto pelo fpags
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cFPags)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                " ctxtcds, clocals," + ;
                " nlnlocals, ncllocals, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                " nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis," + ;
                " nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs," + ;
                " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                " nlncepcobs, nclcepcobs," + ;
                " cnomeimps, cfontepdrs, ntamfontes, ctamfolha" + ;
                " FROM SIGCNFBL" + ;
                " WHERE fpags = " + EscaparSQL(ALLTRIM(par_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves    = TratarNulo(cidchaves,    "C")
            THIS.this_cFPags        = TratarNulo(fpags,        "C")
            THIS.this_cCEmps        = TratarNulo(cemps,        "C")
            THIS.this_dDDatas       = TratarNulo(ddatas,       "D")
            THIS.this_cCHoras       = TratarNulo(choras,       "C")
            THIS.this_cCUsuarios    = TratarNulo(cusuarios,    "C")
            THIS.this_cCTxtCds      = TratarNulo(ctxtcds,      "C")
            THIS.this_cCLocals      = TratarNulo(clocals,      "C")
            THIS.this_nNlnLocals    = TratarNulo(nlnlocals,    "N")
            THIS.this_nNclLocals    = TratarNulo(ncllocals,    "N")
            THIS.this_nNlnDtVencs   = TratarNulo(nlndtvencs,   "N")
            THIS.this_nNclDtVencs   = TratarNulo(ncldtvencs,   "N")
            THIS.this_nNlnDtDocs    = TratarNulo(nlndtdocs,    "N")
            THIS.this_nNclDtDocs    = TratarNulo(ncldtdocs,    "N")
            THIS.this_nNlnNrDocs    = TratarNulo(nlnnrdocs,    "N")
            THIS.this_nNclNrDocs    = TratarNulo(nclnrdocs,    "N")
            THIS.this_nNlnVlDocs    = TratarNulo(nlnvldocs,    "N")
            THIS.this_nNclVlDocs    = TratarNulo(nclvldocs,    "N")
            THIS.this_nNlnTxtCds    = TratarNulo(nlntxtcds,    "N")
            THIS.this_nNclTxtCds    = TratarNulo(ncltxtcds,    "N")
            THIS.this_nNTxtLins     = TratarNulo(ntxtlins,     "N")
            THIS.this_nNTxtCols     = TratarNulo(ntxtcols,     "N")
            THIS.this_nNlnRazClis   = TratarNulo(nlnrazclis,   "N")
            THIS.this_nNclRazClis   = TratarNulo(nclrazclis,   "N")
            THIS.this_nNlnCgcClis   = TratarNulo(nlncgcclis,   "N")
            THIS.this_nNclCgcClis   = TratarNulo(nclcgcclis,   "N")
            THIS.this_nNlnEndCobs   = TratarNulo(nlnendcobs,   "N")
            THIS.this_nNclEndCobs   = TratarNulo(nclendcobs,   "N")
            THIS.this_nNlnBaiCobs   = TratarNulo(nlnbaicobs,   "N")
            THIS.this_nNclBaiCobs   = TratarNulo(nclbaicobs,   "N")
            THIS.this_nNlnCidCobs   = TratarNulo(nlncidcobs,   "N")
            THIS.this_nNclCidCobs   = TratarNulo(nclcidcobs,   "N")
            THIS.this_nNlnEstCobs   = TratarNulo(nlnestcobs,   "N")
            THIS.this_nNclEstCobs   = TratarNulo(nclestcobs,   "N")
            THIS.this_nNlnCepCobs   = TratarNulo(nlncepcobs,   "N")
            THIS.this_nNclCepCobs   = TratarNulo(nclcepcobs,   "N")
            THIS.this_cCNomeImps    = TratarNulo(cnomeimps,    "C")
            THIS.this_cCFontePdrs   = TratarNulo(cfontepdrs,   "C")
            THIS.this_nNTamFontes   = TratarNulo(ntamfontes,   "N")
            THIS.this_cCTamFolha    = TratarNulo(ctamfolha,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere nova configura??o de boleto bancario
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cVals, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCNFBL" + ;
                " (cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                " ctxtcds, clocals," + ;
                " nlnlocals, ncllocals, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                " nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis," + ;
                " nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs," + ;
                " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                " nlncepcobs, nclcepcobs," + ;
                " cnomeimps, cfontepdrs, ntamfontes, ctamfolha)"

            loc_cVals = " VALUES (LEFT(NEWID(), 20)," + ;
                " " + EscaparSQL(ALLTRIM(THIS.this_cFPags)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + "," + ;
                " GETDATE()," + ;
                " " + EscaparSQL(LEFT(TIME(), 8)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + "," + ;
                " " + EscaparSQL(ALLTRIM(THIS.this_cCTxtCds)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCLocals), 100)) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnLocals) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclLocals) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnDtDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclDtDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnNrDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclNrDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnVlDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclVlDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnTxtCds) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclTxtCds) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTxtLins) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTxtCols) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclRazClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCNomeImps), 128)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCFontePdrs), 128)) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTamFontes) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCTamFolha), 50)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL + loc_cVals, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

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
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza configura??o de boleto bancario existente
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCNFBL SET" + ;
                " cemps = " + EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + "," + ;
                " ddatas = GETDATE()," + ;
                " choras = " + EscaparSQL(LEFT(TIME(), 8)) + "," + ;
                " cusuarios = " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + "," + ;
                " ctxtcds = " + EscaparSQL(ALLTRIM(THIS.this_cCTxtCds)) + "," + ;
                " clocals = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCLocals), 100)) + "," + ;
                " nlnlocals = " + FormatarNumeroSQL(THIS.this_nNlnLocals) + "," + ;
                " ncllocals = " + FormatarNumeroSQL(THIS.this_nNclLocals) + "," + ;
                " nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + "," + ;
                " ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + "," + ;
                " nlndtdocs = " + FormatarNumeroSQL(THIS.this_nNlnDtDocs) + "," + ;
                " ncldtdocs = " + FormatarNumeroSQL(THIS.this_nNclDtDocs) + "," + ;
                " nlnnrdocs = " + FormatarNumeroSQL(THIS.this_nNlnNrDocs) + "," + ;
                " nclnrdocs = " + FormatarNumeroSQL(THIS.this_nNclNrDocs) + "," + ;
                " nlnvldocs = " + FormatarNumeroSQL(THIS.this_nNlnVlDocs) + "," + ;
                " nclvldocs = " + FormatarNumeroSQL(THIS.this_nNclVlDocs) + "," + ;
                " nlntxtcds = " + FormatarNumeroSQL(THIS.this_nNlnTxtCds) + "," + ;
                " ncltxtcds = " + FormatarNumeroSQL(THIS.this_nNclTxtCds) + "," + ;
                " ntxtlins = " + FormatarNumeroSQL(THIS.this_nNTxtLins) + "," + ;
                " ntxtcols = " + FormatarNumeroSQL(THIS.this_nNTxtCols) + "," + ;
                " nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + "," + ;
                " nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclRazClis) + "," + ;
                " nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + "," + ;
                " nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + "," + ;
                " nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + "," + ;
                " nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + "," + ;
                " nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + "," + ;
                " nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + "," + ;
                " nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + "," + ;
                " nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + "," + ;
                " nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + "," + ;
                " nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + "," + ;
                " nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + "," + ;
                " nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + "," + ;
                " cnomeimps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCNomeImps), 128)) + "," + ;
                " cfontepdrs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCFontePdrs), 128)) + "," + ;
                " ntamfontes = " + FormatarNumeroSQL(THIS.this_nNTamFontes) + "," + ;
                " ctamfolha = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCTamFolha), 50)) + ;
                " WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

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
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui configura??o de boleto bancario
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCNFBL WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
