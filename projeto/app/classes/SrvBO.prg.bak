*==============================================================================
* SrvBO.prg - Business Object para Servicos (Saidas/Entradas)
* Tabela: SigCdSrv | PK: CodServs
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SrvBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela       = "SigCdSrv"
    this_cCampoChave   = "CodServs"
    this_cMensagemErro = ""

    *-- Campos principais
    this_cCodServs  = ""
    this_cDescServs = ""
    this_cTipos     = "S"
    this_cIdChaves  = ""

    *-- Aliquotas (%)
    this_nAiss     = 0
    this_nApiss    = 0
    this_nAcofinss = 0
    this_nAirrfs   = 0
    this_nAinss    = 0
    this_nAcslls   = 0

    *-- Valores Minimos a recolher
    this_nVminpiss   = 0
    this_nVmincofins = 0
    this_nVMinIrrfs  = 0
    this_nVMinInss   = 0
    this_nVMinCslls  = 0

    *-- Base de Calculo Minima
    this_nVminbpiss  = 0
    this_nVminbcofin = 0
    this_nVMinbIrrfs = 0
    this_nVMinbInss  = 0
    this_nVMinbCslls = 0

    *-- Lancamento Financeiro (numericos: 0=desmarcado, 1=marcado)
    this_nNLanFPiss  = 0
    this_nNLanFCofin = 0
    this_nNLanFIrrfs = 0
    this_nNLanFInss  = 0
    this_nNLanFIss   = 0
    this_nNLanFCslls = 0

    *-- Periodicidade Mensal (numericos: 0=desmarcado, 1=marcado)
    this_nBpisms   = 0
    this_nBcofinms = 0
    this_nBirrfms  = 0
    this_nBinssms  = 0
    this_nBcsllms  = 0

    *-- Codigos de Ocorrencia
    this_cOcorPiss  = ""
    this_cOcorCofin = ""
    this_cOcorIrrfs = ""
    this_cOcorInss  = ""
    this_cOcorCslls = ""
    this_cOcoriSS   = ""

    *-- Conta Contabil (PIS - principal)
    this_cGrupo  = ""
    this_cContab = ""

    *-- Vencimentos (1=Titulo, 2=10 D F Mes, 3=Ult Dia Util Quinz Seg)
    this_nVcpis    = 1
    this_nVccofins = 1
    this_nVcirrf   = 1
    this_nVcinss   = 1
    this_nVccsll   = 1
    this_nVciss    = 1

    *-- Grupos/Contas Contabeis por imposto (Vencimentos)
    this_cGrppiss   = ""
    this_cCtaPiss   = ""
    this_cGrpCofins = ""
    this_cCtaCofins = ""
    this_cGrpIrrfs  = ""
    this_cCtaIrrfs  = ""
    this_cGrpInss   = ""
    this_cCtaInss   = ""
    this_cGrpCslls  = ""
    this_cCtaCslls  = ""
    this_cGrpIss    = ""
    this_cCtaIss    = ""

    *-- Codigos de retencao (nao-RPA): PIS, COFINS, CSLL
    this_cCodpiss    = ""
    this_cCodcofinss = ""
    this_cCodcslls   = ""

    *-- Codigos DARF (RPA): PIS, COFINS, CSLL, IRRF
    this_cCodrecpis  = ""
    this_cCodreccof  = ""
    this_cCodreccsll = ""
    this_cCodrecirrf = ""

    *-- RPA (1=Sim, 2=Nao)
    this_nNrpas      = 2
    this_nMaxretinss = 0

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdSrv")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodServs
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa todas as propriedades
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cCodServs  = ""
        THIS.this_cDescServs = ""
        THIS.this_cIdChaves  = ""
        THIS.this_nAiss      = 0
        THIS.this_nApiss     = 0
        THIS.this_nAcofinss  = 0
        THIS.this_nAirrfs    = 0
        THIS.this_nAinss     = 0
        THIS.this_nAcslls    = 0
        THIS.this_nVminpiss   = 0
        THIS.this_nVmincofins = 0
        THIS.this_nVMinIrrfs  = 0
        THIS.this_nVMinInss   = 0
        THIS.this_nVMinCslls  = 0
        THIS.this_nVminbpiss  = 0
        THIS.this_nVminbcofin = 0
        THIS.this_nVMinbIrrfs = 0
        THIS.this_nVMinbInss  = 0
        THIS.this_nVMinbCslls = 0
        THIS.this_nNLanFPiss  = 0
        THIS.this_nNLanFCofin = 0
        THIS.this_nNLanFIrrfs = 0
        THIS.this_nNLanFInss  = 0
        THIS.this_nNLanFIss   = 0
        THIS.this_nNLanFCslls = 0
        THIS.this_nBpisms     = 0
        THIS.this_nBcofinms   = 0
        THIS.this_nBirrfms    = 0
        THIS.this_nBinssms    = 0
        THIS.this_nBcsllms    = 0
        THIS.this_cOcorPiss   = ""
        THIS.this_cOcorCofin  = ""
        THIS.this_cOcorIrrfs  = ""
        THIS.this_cOcorInss   = ""
        THIS.this_cOcorCslls  = ""
        THIS.this_cOcoriSS    = ""
        THIS.this_cGrupo      = ""
        THIS.this_cContab     = ""
        THIS.this_nVcpis      = 1
        THIS.this_nVccofins   = 1
        THIS.this_nVcirrf     = 1
        THIS.this_nVcinss     = 1
        THIS.this_nVccsll     = 1
        THIS.this_nVciss      = 1
        THIS.this_cGrppiss    = ""
        THIS.this_cCtaPiss    = ""
        THIS.this_cGrpCofins  = ""
        THIS.this_cCtaCofins  = ""
        THIS.this_cGrpIrrfs   = ""
        THIS.this_cCtaIrrfs   = ""
        THIS.this_cGrpInss    = ""
        THIS.this_cCtaInss    = ""
        THIS.this_cGrpCslls   = ""
        THIS.this_cCtaCslls   = ""
        THIS.this_cGrpIss     = ""
        THIS.this_cCtaIss     = ""
        THIS.this_cCodpiss    = ""
        THIS.this_cCodcofinss = ""
        THIS.this_cCodcslls   = ""
        THIS.this_cCodrecpis  = ""
        THIS.this_cCodreccof  = ""
        THIS.this_cCodreccsll = ""
        THIS.this_cCodrecirrf = ""
        THIS.this_nNrpas      = 2
        THIS.this_nMaxretinss = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes de negocio antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodServs))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do Servi" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cDescServs))
            THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o do Servi" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdSrv
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        loc_cSQL = "INSERT INTO SigCdSrv (" + ;
                   "codservs, DescServs, cTipos, cIdChaves, " + ;
                   "aiss, apiss, acofinss, airrfs, ainss, acslls, " + ;
                   "vminpiss, vmincofins, vMinIrrfs, vMinInss, vMinCslls, " + ;
                   "vminbpiss, vminbcofin, vMinbIrrfs, vMinbInss, vMinbCslls, " + ;
                   "nlanfpiss, nLanFCofin, nLanFIrrfs, nLanFInss, nLanFIss, nLanFCslls, " + ;
                   "bpisms, bcofinms, birrfms, binssms, bcsllms, " + ;
                   "cocorpiss, cOcorCofin, cOcorIrrfs, cOcorInss, cOcorCslls, cOcoriSS, " + ;
                   "cgrupo, cContab, vcpis, vccofins, vcirrf, vcinss, vccsll, vciss, " + ;
                   "cgrppiss, cCtaPiss, cGrpCofins, cCtaCofins, cGrpIrrfs, cCtaIrrfs, " + ;
                   "cgrpinss, cCtaInss, cGrpCslls, cCtaCslls, cGrpIss, cCtaIss, " + ;
                   "codpiss, codcofinss, codcslls, codrecpis, codreccof, codreccsll, codrecirrf, " + ;
                   "nrpas, maxretinss" + ;
                   ") VALUES (" + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCodServs)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cDescServs)) + ", " + ;
                   EscaparSQL(THIS.this_cTipos) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAiss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nApiss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAcofinss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAirrfs) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAinss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAcslls) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVminpiss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVmincofins) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVMinIrrfs) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVMinInss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVMinCslls) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVminbpiss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVminbcofin) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVMinbIrrfs) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVMinbInss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVMinbCslls) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNLanFPiss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNLanFCofin) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNLanFIrrfs) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNLanFInss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNLanFIss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNLanFCslls) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nBpisms) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nBcofinms) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nBirrfms) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nBinssms) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nBcsllms) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cOcorPiss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cOcorCofin)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cOcorIrrfs)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cOcorInss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cOcorCslls)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cOcoriSS)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cContab)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVcpis) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVccofins) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVcirrf) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVcinss) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVccsll) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVciss) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cGrppiss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCtaPiss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cGrpCofins)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCtaCofins)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cGrpIrrfs)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCtaIrrfs)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cGrpInss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCtaInss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cGrpCslls)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCtaCslls)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cGrpIss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCtaIss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCodpiss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCodcofinss)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCodcslls)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCodrecpis)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCodreccof)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCodreccsll)) + ", " + ;
                   EscaparSQL(ALLTRIM(THIS.this_cCodrecirrf)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNrpas) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nMaxretinss) + ")"
        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nRet > 0
            THIS.RegistrarAuditoria("INSERT")
            loc_lResultado = .T.
        ELSE
            THIS.this_cMensagemErro = "Erro ao inserir servi" + CHR(231) + CHR(227) + "o"
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdSrv
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        loc_cSQL = "UPDATE SigCdSrv SET " + ;
                   "DescServs = "    + EscaparSQL(ALLTRIM(THIS.this_cDescServs)) + ", " + ;
                   "cIdChaves = "    + EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ", " + ;
                   "aiss = "         + FormatarNumeroSQL(THIS.this_nAiss) + ", " + ;
                   "apiss = "        + FormatarNumeroSQL(THIS.this_nApiss) + ", " + ;
                   "acofinss = "     + FormatarNumeroSQL(THIS.this_nAcofinss) + ", " + ;
                   "airrfs = "       + FormatarNumeroSQL(THIS.this_nAirrfs) + ", " + ;
                   "ainss = "        + FormatarNumeroSQL(THIS.this_nAinss) + ", " + ;
                   "acslls = "       + FormatarNumeroSQL(THIS.this_nAcslls) + ", " + ;
                   "vminpiss = "     + FormatarNumeroSQL(THIS.this_nVminpiss) + ", " + ;
                   "vmincofins = "   + FormatarNumeroSQL(THIS.this_nVmincofins) + ", " + ;
                   "vMinIrrfs = "    + FormatarNumeroSQL(THIS.this_nVMinIrrfs) + ", " + ;
                   "vMinInss = "     + FormatarNumeroSQL(THIS.this_nVMinInss) + ", " + ;
                   "vMinCslls = "    + FormatarNumeroSQL(THIS.this_nVMinCslls) + ", " + ;
                   "vminbpiss = "    + FormatarNumeroSQL(THIS.this_nVminbpiss) + ", " + ;
                   "vminbcofin = "   + FormatarNumeroSQL(THIS.this_nVminbcofin) + ", " + ;
                   "vMinbIrrfs = "   + FormatarNumeroSQL(THIS.this_nVMinbIrrfs) + ", " + ;
                   "vMinbInss = "    + FormatarNumeroSQL(THIS.this_nVMinbInss) + ", " + ;
                   "vMinbCslls = "   + FormatarNumeroSQL(THIS.this_nVMinbCslls) + ", " + ;
                   "nLanFPiss = "    + FormatarNumeroSQL(THIS.this_nNLanFPiss) + ", " + ;
                   "nLanFCofin = "   + FormatarNumeroSQL(THIS.this_nNLanFCofin) + ", " + ;
                   "nLanFIrrfs = "   + FormatarNumeroSQL(THIS.this_nNLanFIrrfs) + ", " + ;
                   "nLanFInss = "    + FormatarNumeroSQL(THIS.this_nNLanFInss) + ", " + ;
                   "nLanFIss = "     + FormatarNumeroSQL(THIS.this_nNLanFIss) + ", " + ;
                   "nLanFCslls = "   + FormatarNumeroSQL(THIS.this_nNLanFCslls) + ", " + ;
                   "bpisms = "       + FormatarNumeroSQL(THIS.this_nBpisms) + ", " + ;
                   "bcofinms = "     + FormatarNumeroSQL(THIS.this_nBcofinms) + ", " + ;
                   "birrfms = "      + FormatarNumeroSQL(THIS.this_nBirrfms) + ", " + ;
                   "binssms = "      + FormatarNumeroSQL(THIS.this_nBinssms) + ", " + ;
                   "bcsllms = "      + FormatarNumeroSQL(THIS.this_nBcsllms) + ", " + ;
                   "cOcorPiss = "    + EscaparSQL(ALLTRIM(THIS.this_cOcorPiss)) + ", " + ;
                   "cOcorCofin = "   + EscaparSQL(ALLTRIM(THIS.this_cOcorCofin)) + ", " + ;
                   "cOcorIrrfs = "   + EscaparSQL(ALLTRIM(THIS.this_cOcorIrrfs)) + ", " + ;
                   "cOcorInss = "    + EscaparSQL(ALLTRIM(THIS.this_cOcorInss)) + ", " + ;
                   "cOcorCslls = "   + EscaparSQL(ALLTRIM(THIS.this_cOcorCslls)) + ", " + ;
                   "cOcoriSS = "     + EscaparSQL(ALLTRIM(THIS.this_cOcoriSS)) + ", " + ;
                   "cGrupo = "       + EscaparSQL(ALLTRIM(THIS.this_cGrupo)) + ", " + ;
                   "cContab = "      + EscaparSQL(ALLTRIM(THIS.this_cContab)) + ", " + ;
                   "vcpis = "        + FormatarNumeroSQL(THIS.this_nVcpis) + ", " + ;
                   "vccofins = "     + FormatarNumeroSQL(THIS.this_nVccofins) + ", " + ;
                   "vcirrf = "       + FormatarNumeroSQL(THIS.this_nVcirrf) + ", " + ;
                   "vcinss = "       + FormatarNumeroSQL(THIS.this_nVcinss) + ", " + ;
                   "vccsll = "       + FormatarNumeroSQL(THIS.this_nVccsll) + ", " + ;
                   "vciss = "        + FormatarNumeroSQL(THIS.this_nVciss) + ", " + ;
                   "cGrppiss = "     + EscaparSQL(ALLTRIM(THIS.this_cGrppiss)) + ", " + ;
                   "cCtaPiss = "     + EscaparSQL(ALLTRIM(THIS.this_cCtaPiss)) + ", " + ;
                   "cGrpCofins = "   + EscaparSQL(ALLTRIM(THIS.this_cGrpCofins)) + ", " + ;
                   "cCtaCofins = "   + EscaparSQL(ALLTRIM(THIS.this_cCtaCofins)) + ", " + ;
                   "cGrpIrrfs = "    + EscaparSQL(ALLTRIM(THIS.this_cGrpIrrfs)) + ", " + ;
                   "cCtaIrrfs = "    + EscaparSQL(ALLTRIM(THIS.this_cCtaIrrfs)) + ", " + ;
                   "cGrpInss = "     + EscaparSQL(ALLTRIM(THIS.this_cGrpInss)) + ", " + ;
                   "cCtaInss = "     + EscaparSQL(ALLTRIM(THIS.this_cCtaInss)) + ", " + ;
                   "cGrpCslls = "    + EscaparSQL(ALLTRIM(THIS.this_cGrpCslls)) + ", " + ;
                   "cCtaCslls = "    + EscaparSQL(ALLTRIM(THIS.this_cCtaCslls)) + ", " + ;
                   "cGrpIss = "      + EscaparSQL(ALLTRIM(THIS.this_cGrpIss)) + ", " + ;
                   "cCtaIss = "      + EscaparSQL(ALLTRIM(THIS.this_cCtaIss)) + ", " + ;
                   "codpiss = "      + EscaparSQL(ALLTRIM(THIS.this_cCodpiss)) + ", " + ;
                   "codcofinss = "   + EscaparSQL(ALLTRIM(THIS.this_cCodcofinss)) + ", " + ;
                   "codcslls = "     + EscaparSQL(ALLTRIM(THIS.this_cCodcslls)) + ", " + ;
                   "codrecpis = "    + EscaparSQL(ALLTRIM(THIS.this_cCodrecpis)) + ", " + ;
                   "codreccof = "    + EscaparSQL(ALLTRIM(THIS.this_cCodreccof)) + ", " + ;
                   "codreccsll = "   + EscaparSQL(ALLTRIM(THIS.this_cCodreccsll)) + ", " + ;
                   "codrecirrf = "   + EscaparSQL(ALLTRIM(THIS.this_cCodrecirrf)) + ", " + ;
                   "nrpas = "        + FormatarNumeroSQL(THIS.this_nNrpas) + ", " + ;
                   "maxretinss = "   + FormatarNumeroSQL(THIS.this_nMaxretinss) + ;
                   " WHERE CodServs = " + EscaparSQL(ALLTRIM(THIS.this_cCodServs)) + ;
                   " AND cTipos = "    + EscaparSQL(THIS.this_cTipos)
        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nRet > 0
            THIS.RegistrarAuditoria("UPDATE")
            loc_lResultado = .T.
        ELSE
            THIS.this_cMensagemErro = "Erro ao atualizar servi" + CHR(231) + CHR(227) + "o"
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigSeRvp e SigCdSrv
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Exclui produtos vinculados primeiro
            loc_cSQL = "DELETE FROM SigSeRvp WHERE CodServs = " + EscaparSQL(ALLTRIM(THIS.this_cCodServs))
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Exclui o servico
            loc_cSQL = "DELETE FROM SigCdSrv WHERE CodServs = " + EscaparSQL(ALLTRIM(THIS.this_cCodServs)) + ;
                       " AND cTipos = " + EscaparSQL(THIS.this_cTipos)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir servi" + CHR(231) + CHR(227) + "o"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT SigCdSrv filtrado por cTipos e filtro opcional
    * Popula cursor_4c_Dados (protegido via temp)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cWhere = "cTipos = " + EscaparSQL(THIS.this_cTipos)
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = loc_cWhere + " AND CodServs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdSrv WHERE " + loc_cWhere + " ORDER BY CodServs"
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
            IF loc_nRet > 0
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SELECT * FROM cursor_4c_DadosTemp INTO CURSOR cursor_4c_Dados READWRITE
                USE IN cursor_4c_DadosTemp
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar servi" + CHR(231) + CHR(227) + "os"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega propriedades do BO a partir do banco
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigCdSrv WHERE CodServs = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " AND cTipos = " + EscaparSQL(THIS.this_cTipos)
            IF USED("cursor_4c_CarregaTemp")
                USE IN cursor_4c_CarregaTemp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaTemp")
            IF loc_nRet > 0 AND USED("cursor_4c_CarregaTemp") AND !EOF("cursor_4c_CarregaTemp")
                THIS.this_cCodServs   = ALLTRIM(cursor_4c_CarregaTemp.CodServs)
                THIS.this_cDescServs  = ALLTRIM(cursor_4c_CarregaTemp.DescServs)
                THIS.this_cIdChaves   = ALLTRIM(NVL(cursor_4c_CarregaTemp.cIdChaves, ""))
                THIS.this_nAiss       = NVL(cursor_4c_CarregaTemp.aiss, 0)
                THIS.this_nApiss      = NVL(cursor_4c_CarregaTemp.apiss, 0)
                THIS.this_nAcofinss   = NVL(cursor_4c_CarregaTemp.acofinss, 0)
                THIS.this_nAirrfs     = NVL(cursor_4c_CarregaTemp.airrfs, 0)
                THIS.this_nAinss      = NVL(cursor_4c_CarregaTemp.ainss, 0)
                THIS.this_nAcslls     = NVL(cursor_4c_CarregaTemp.acslls, 0)
                THIS.this_nVminpiss   = NVL(cursor_4c_CarregaTemp.vminpiss, 0)
                THIS.this_nVmincofins = NVL(cursor_4c_CarregaTemp.vmincofins, 0)
                THIS.this_nVMinIrrfs  = NVL(cursor_4c_CarregaTemp.vMinIrrfs, 0)
                THIS.this_nVMinInss   = NVL(cursor_4c_CarregaTemp.vMinInss, 0)
                THIS.this_nVMinCslls  = NVL(cursor_4c_CarregaTemp.vMinCslls, 0)
                THIS.this_nVminbpiss  = NVL(cursor_4c_CarregaTemp.vminbpiss, 0)
                THIS.this_nVminbcofin = NVL(cursor_4c_CarregaTemp.vminbcofin, 0)
                THIS.this_nVMinbIrrfs = NVL(cursor_4c_CarregaTemp.vMinbIrrfs, 0)
                THIS.this_nVMinbInss  = NVL(cursor_4c_CarregaTemp.vMinbInss, 0)
                THIS.this_nVMinbCslls = NVL(cursor_4c_CarregaTemp.vMinbCslls, 0)
                THIS.this_nNLanFPiss  = NVL(cursor_4c_CarregaTemp.nLanFPiss, 0)
                THIS.this_nNLanFCofin = NVL(cursor_4c_CarregaTemp.nLanFCofin, 0)
                THIS.this_nNLanFIrrfs = NVL(cursor_4c_CarregaTemp.nLanFIrrfs, 0)
                THIS.this_nNLanFInss  = NVL(cursor_4c_CarregaTemp.nLanFInss, 0)
                THIS.this_nNLanFIss   = NVL(cursor_4c_CarregaTemp.nLanFIss, 0)
                THIS.this_nNLanFCslls = NVL(cursor_4c_CarregaTemp.nLanFCslls, 0)
                THIS.this_nBpisms     = NVL(cursor_4c_CarregaTemp.bpisms, 0)
                THIS.this_nBcofinms   = NVL(cursor_4c_CarregaTemp.bcofinms, 0)
                THIS.this_nBirrfms    = NVL(cursor_4c_CarregaTemp.birrfms, 0)
                THIS.this_nBinssms    = NVL(cursor_4c_CarregaTemp.binssms, 0)
                THIS.this_nBcsllms    = NVL(cursor_4c_CarregaTemp.bcsllms, 0)
                THIS.this_cOcorPiss   = ALLTRIM(NVL(cursor_4c_CarregaTemp.cOcorPiss, ""))
                THIS.this_cOcorCofin  = ALLTRIM(NVL(cursor_4c_CarregaTemp.cOcorCofin, ""))
                THIS.this_cOcorIrrfs  = ALLTRIM(NVL(cursor_4c_CarregaTemp.cOcorIrrfs, ""))
                THIS.this_cOcorInss   = ALLTRIM(NVL(cursor_4c_CarregaTemp.cOcorInss, ""))
                THIS.this_cOcorCslls  = ALLTRIM(NVL(cursor_4c_CarregaTemp.cOcorCslls, ""))
                THIS.this_cOcoriSS    = ALLTRIM(NVL(cursor_4c_CarregaTemp.cOcoriSS, ""))
                THIS.this_cGrupo      = ALLTRIM(NVL(cursor_4c_CarregaTemp.cGrupo, ""))
                THIS.this_cContab     = ALLTRIM(NVL(cursor_4c_CarregaTemp.cContab, ""))
                THIS.this_nVcpis      = NVL(cursor_4c_CarregaTemp.vcpis, 1)
                THIS.this_nVccofins   = NVL(cursor_4c_CarregaTemp.vccofins, 1)
                THIS.this_nVcirrf     = NVL(cursor_4c_CarregaTemp.vcirrf, 1)
                THIS.this_nVcinss     = NVL(cursor_4c_CarregaTemp.vcinss, 1)
                THIS.this_nVccsll     = NVL(cursor_4c_CarregaTemp.vccsll, 1)
                THIS.this_nVciss      = NVL(cursor_4c_CarregaTemp.vciss, 1)
                THIS.this_cGrppiss    = ALLTRIM(NVL(cursor_4c_CarregaTemp.cGrppiss, ""))
                THIS.this_cCtaPiss    = ALLTRIM(NVL(cursor_4c_CarregaTemp.cCtaPiss, ""))
                THIS.this_cGrpCofins  = ALLTRIM(NVL(cursor_4c_CarregaTemp.cGrpCofins, ""))
                THIS.this_cCtaCofins  = ALLTRIM(NVL(cursor_4c_CarregaTemp.cCtaCofins, ""))
                THIS.this_cGrpIrrfs   = ALLTRIM(NVL(cursor_4c_CarregaTemp.cGrpIrrfs, ""))
                THIS.this_cCtaIrrfs   = ALLTRIM(NVL(cursor_4c_CarregaTemp.cCtaIrrfs, ""))
                THIS.this_cGrpInss    = ALLTRIM(NVL(cursor_4c_CarregaTemp.cGrpInss, ""))
                THIS.this_cCtaInss    = ALLTRIM(NVL(cursor_4c_CarregaTemp.cCtaInss, ""))
                THIS.this_cGrpCslls   = ALLTRIM(NVL(cursor_4c_CarregaTemp.cGrpCslls, ""))
                THIS.this_cCtaCslls   = ALLTRIM(NVL(cursor_4c_CarregaTemp.cCtaCslls, ""))
                THIS.this_cGrpIss     = ALLTRIM(NVL(cursor_4c_CarregaTemp.cGrpIss, ""))
                THIS.this_cCtaIss     = ALLTRIM(NVL(cursor_4c_CarregaTemp.cCtaIss, ""))
                THIS.this_cCodpiss    = ALLTRIM(NVL(cursor_4c_CarregaTemp.codpiss, ""))
                THIS.this_cCodcofinss = ALLTRIM(NVL(cursor_4c_CarregaTemp.codcofinss, ""))
                THIS.this_cCodcslls   = ALLTRIM(NVL(cursor_4c_CarregaTemp.codcslls, ""))
                THIS.this_cCodrecpis  = ALLTRIM(NVL(cursor_4c_CarregaTemp.codrecpis, ""))
                THIS.this_cCodreccof  = ALLTRIM(NVL(cursor_4c_CarregaTemp.codreccof, ""))
                THIS.this_cCodreccsll = ALLTRIM(NVL(cursor_4c_CarregaTemp.codreccsll, ""))
                THIS.this_cCodrecirrf = ALLTRIM(NVL(cursor_4c_CarregaTemp.codrecirrf, ""))
                THIS.this_nNrpas      = NVL(cursor_4c_CarregaTemp.nrpas, 2)
                THIS.this_nMaxretinss = NVL(cursor_4c_CarregaTemp.maxretinss, 0)
                THIS.this_lNovoRegistro = .F.
                USE IN cursor_4c_CarregaTemp
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Servi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrado"
                IF USED("cursor_4c_CarregaTemp")
                    USE IN cursor_4c_CarregaTemp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            IF USED("cursor_4c_CarregaTemp")
                USE IN cursor_4c_CarregaTemp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades do BO a partir de cursor posicionado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF NOT (USED(par_cAlias) AND !EOF(par_cAlias))
                THIS.this_cMensagemErro = "Cursor " + par_cAlias + " n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            ELSE
                THIS.this_cCodServs   = ALLTRIM(EVALUATE(par_cAlias + ".CodServs"))
                THIS.this_cDescServs  = ALLTRIM(EVALUATE(par_cAlias + ".DescServs"))
                THIS.this_cIdChaves   = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cIdChaves"), ""))
                THIS.this_nAiss       = NVL(EVALUATE(par_cAlias + ".aiss"), 0)
                THIS.this_nApiss      = NVL(EVALUATE(par_cAlias + ".apiss"), 0)
                THIS.this_nAcofinss   = NVL(EVALUATE(par_cAlias + ".acofinss"), 0)
                THIS.this_nAirrfs     = NVL(EVALUATE(par_cAlias + ".airrfs"), 0)
                THIS.this_nAinss      = NVL(EVALUATE(par_cAlias + ".ainss"), 0)
                THIS.this_nAcslls     = NVL(EVALUATE(par_cAlias + ".acslls"), 0)
                THIS.this_nVminpiss   = NVL(EVALUATE(par_cAlias + ".vminpiss"), 0)
                THIS.this_nVmincofins = NVL(EVALUATE(par_cAlias + ".vmincofins"), 0)
                THIS.this_nVMinIrrfs  = NVL(EVALUATE(par_cAlias + ".vMinIrrfs"), 0)
                THIS.this_nVMinInss   = NVL(EVALUATE(par_cAlias + ".vMinInss"), 0)
                THIS.this_nVMinCslls  = NVL(EVALUATE(par_cAlias + ".vMinCslls"), 0)
                THIS.this_nVminbpiss  = NVL(EVALUATE(par_cAlias + ".vminbpiss"), 0)
                THIS.this_nVminbcofin = NVL(EVALUATE(par_cAlias + ".vminbcofin"), 0)
                THIS.this_nVMinbIrrfs = NVL(EVALUATE(par_cAlias + ".vMinbIrrfs"), 0)
                THIS.this_nVMinbInss  = NVL(EVALUATE(par_cAlias + ".vMinbInss"), 0)
                THIS.this_nVMinbCslls = NVL(EVALUATE(par_cAlias + ".vMinbCslls"), 0)
                THIS.this_nNLanFPiss  = NVL(EVALUATE(par_cAlias + ".nLanFPiss"), 0)
                THIS.this_nNLanFCofin = NVL(EVALUATE(par_cAlias + ".nLanFCofin"), 0)
                THIS.this_nNLanFIrrfs = NVL(EVALUATE(par_cAlias + ".nLanFIrrfs"), 0)
                THIS.this_nNLanFInss  = NVL(EVALUATE(par_cAlias + ".nLanFInss"), 0)
                THIS.this_nNLanFIss   = NVL(EVALUATE(par_cAlias + ".nLanFIss"), 0)
                THIS.this_nNLanFCslls = NVL(EVALUATE(par_cAlias + ".nLanFCslls"), 0)
                THIS.this_nBpisms     = NVL(EVALUATE(par_cAlias + ".bpisms"), 0)
                THIS.this_nBcofinms   = NVL(EVALUATE(par_cAlias + ".bcofinms"), 0)
                THIS.this_nBirrfms    = NVL(EVALUATE(par_cAlias + ".birrfms"), 0)
                THIS.this_nBinssms    = NVL(EVALUATE(par_cAlias + ".binssms"), 0)
                THIS.this_nBcsllms    = NVL(EVALUATE(par_cAlias + ".bcsllms"), 0)
                THIS.this_cOcorPiss   = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cOcorPiss"), ""))
                THIS.this_cOcorCofin  = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cOcorCofin"), ""))
                THIS.this_cOcorIrrfs  = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cOcorIrrfs"), ""))
                THIS.this_cOcorInss   = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cOcorInss"), ""))
                THIS.this_cOcorCslls  = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cOcorCslls"), ""))
                THIS.this_cOcoriSS    = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cOcoriSS"), ""))
                THIS.this_cGrupo      = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cGrupo"), ""))
                THIS.this_cContab     = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cContab"), ""))
                THIS.this_nVcpis      = NVL(EVALUATE(par_cAlias + ".vcpis"), 1)
                THIS.this_nVccofins   = NVL(EVALUATE(par_cAlias + ".vccofins"), 1)
                THIS.this_nVcirrf     = NVL(EVALUATE(par_cAlias + ".vcirrf"), 1)
                THIS.this_nVcinss     = NVL(EVALUATE(par_cAlias + ".vcinss"), 1)
                THIS.this_nVccsll     = NVL(EVALUATE(par_cAlias + ".vccsll"), 1)
                THIS.this_nVciss      = NVL(EVALUATE(par_cAlias + ".vciss"), 1)
                THIS.this_cGrppiss    = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cGrppiss"), ""))
                THIS.this_cCtaPiss    = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cCtaPiss"), ""))
                THIS.this_cGrpCofins  = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cGrpCofins"), ""))
                THIS.this_cCtaCofins  = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cCtaCofins"), ""))
                THIS.this_cGrpIrrfs   = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cGrpIrrfs"), ""))
                THIS.this_cCtaIrrfs   = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cCtaIrrfs"), ""))
                THIS.this_cGrpInss    = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cGrpInss"), ""))
                THIS.this_cCtaInss    = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cCtaInss"), ""))
                THIS.this_cGrpCslls   = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cGrpCslls"), ""))
                THIS.this_cCtaCslls   = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cCtaCslls"), ""))
                THIS.this_cGrpIss     = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cGrpIss"), ""))
                THIS.this_cCtaIss     = ALLTRIM(NVL(EVALUATE(par_cAlias + ".cCtaIss"), ""))
                THIS.this_cCodpiss    = ALLTRIM(NVL(EVALUATE(par_cAlias + ".codpiss"), ""))
                THIS.this_cCodcofinss = ALLTRIM(NVL(EVALUATE(par_cAlias + ".codcofinss"), ""))
                THIS.this_cCodcslls   = ALLTRIM(NVL(EVALUATE(par_cAlias + ".codcslls"), ""))
                THIS.this_cCodrecpis  = ALLTRIM(NVL(EVALUATE(par_cAlias + ".codrecpis"), ""))
                THIS.this_cCodreccof  = ALLTRIM(NVL(EVALUATE(par_cAlias + ".codreccof"), ""))
                THIS.this_cCodreccsll = ALLTRIM(NVL(EVALUATE(par_cAlias + ".codreccsll"), ""))
                THIS.this_cCodrecirrf = ALLTRIM(NVL(EVALUATE(par_cAlias + ".codrecirrf"), ""))
                THIS.this_nNrpas      = NVL(EVALUATE(par_cAlias + ".nrpas"), 2)
                THIS.this_nMaxretinss = NVL(EVALUATE(par_cAlias + ".maxretinss"), 0)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
