*==============================================================================
* SigPrRetBO.PRG
* Business Object - Operacional: Retorno de Estoque (Etiquetas)
*
* Herda de BusinessBase
* Form de filtros que abre SigOpIpE com variaveis PRIVATE.
* Sem CRUD - armazena parametros de filtro para consulta/digitacao/arquivadas.
*==============================================================================

DEFINE CLASS SigPrRetBO AS BusinessBase

    *-- Sem tabela primaria (form operacional de filtros)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Empresa
    this_cCdEmpresa   = ""
    this_cDsEmpresa   = ""

    *-- Periodo
    this_dDtInicial   = {}
    this_dDtFinal     = {}

    *-- Operacao / Industria / Numero NF
    this_cNmOperacao  = ""
    this_cNmIndustria = ""
    this_nNumero      = 0
    this_nNumerof     = 0

    *-- Produto (SigCdPro: CPros / DPros)
    this_cCodProduto  = ""
    this_cDsProduto   = ""

    *-- Etiqueta (SigOpEtq: CBars n(14))
    this_nEtiqIni     = 0
    this_nEtiqFim     = 0
    this_nQtdEti      = 0

    *-- Grupo Estoque / Estoque
    this_cCdGrEstoque = ""
    this_cDsGrEstoque = ""
    this_cCdEstoque   = ""
    this_cDsEstoque   = ""

    *-- Grande Grupo (SigCdGpr: Codigos char(3))
    this_cGdeGrupo    = ""

    *-- Grupo Produto (SigCdGrp: CGrus char(3) / DGrus char(20))
    this_cCgru        = ""
    this_cDgru        = ""

    *-- Sub-Grupo (SigCdPsg: Codigos char(6) / Descricaos char(20))
    this_cCSGru       = ""
    this_cDSGru       = ""

    *-- Grupo Venda / Colecao (SigCdCol: Colecoes / Descs)
    this_cCol         = ""
    this_cDCol        = ""

    *-- Linha (SigCdLin: linhas char(10))
    this_cLin         = ""

    *-- Local do Produto (SigPrLcl: Codigos char(10))
    this_cLocal       = ""

    *-- Local da Etiqueta (SigPrLcl: Codigos char(10))
    this_cLocalizas   = ""

    *-- Promocao (SigPrPmc: promos char(25))
    this_cPromos      = ""

    *-- Opcoes de impressao / ordenacao
    this_nOrdem       = 1
    this_nOptMarcas   = 1
    this_nChkPreco    = 2

    *-- Controle interno
    this_cTipo        = ""
    this_cOpEscolha   = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem tabela primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega this_* a partir de cursor com parametros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCdEmpresa   = TratarNulo(CdEmpresa,   "C")
                THIS.this_cDsEmpresa   = TratarNulo(DsEmpresa,   "C")
                THIS.this_dDtInicial   = TratarNulo(DtInicial,   "D")
                THIS.this_dDtFinal     = TratarNulo(DtFinal,     "D")
                THIS.this_cNmOperacao  = TratarNulo(NmOperacao,  "C")
                THIS.this_cNmIndustria = TratarNulo(NmIndustria, "C")
                THIS.this_nNumero      = TratarNulo(Numero,      "N")
                THIS.this_nNumerof     = TratarNulo(Numerof,     "N")
                THIS.this_cCodProduto  = TratarNulo(CPros,       "C")
                THIS.this_cDsProduto   = TratarNulo(DPros,       "C")
                THIS.this_nEtiqIni     = TratarNulo(EtiqIni,     "N")
                THIS.this_nEtiqFim     = TratarNulo(EtiqFim,     "N")
                THIS.this_nQtdEti      = TratarNulo(QtdEti,      "N")
                THIS.this_cCdGrEstoque = TratarNulo(CdGrEstoque, "C")
                THIS.this_cDsGrEstoque = TratarNulo(DsGrEstoque, "C")
                THIS.this_cCdEstoque   = TratarNulo(CdEstoque,   "C")
                THIS.this_cDsEstoque   = TratarNulo(DsEstoque,   "C")
                THIS.this_cGdeGrupo    = TratarNulo(GdeGrupo,    "C")
                THIS.this_cCgru        = TratarNulo(CGrus,       "C")
                THIS.this_cDgru        = TratarNulo(DGrus,       "C")
                THIS.this_cCSGru       = TratarNulo(CSGru,       "C")
                THIS.this_cDSGru       = TratarNulo(DSGru,       "C")
                THIS.this_cCol         = TratarNulo(Colecoes,    "C")
                THIS.this_cDCol        = TratarNulo(Descs,       "C")
                THIS.this_cLin         = TratarNulo(Linhas,      "C")
                THIS.this_cLocal       = TratarNulo(CdLocal,     "C")
                THIS.this_cLocalizas   = TratarNulo(Localizas,   "C")
                THIS.this_cPromos      = TratarNulo(Promos,      "C")
                THIS.this_nOrdem       = TratarNulo(Ordem,       "N")
                THIS.this_nOptMarcas   = TratarNulo(OptMarcas,   "N")
                THIS.this_nChkPreco    = TratarNulo(ChkPreco,    "N")
                THIS.this_cTipo        = TratarNulo(Tipo,        "C")
                THIS.this_cOpEscolha   = TratarNulo(OpEscolha,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Carrega SigCdOpd para lookup de operacoes por SEEK
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("SigCdOpd")
                USE IN SigCdOpd
            ENDIF
            loc_cSQL = "SELECT a.* FROM SigCdOpd a"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "SigCdOpd") > 0
                SELECT SigCdOpd
                INDEX ON dopps TAG dopps
                SET ORDER TO
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEtiqueta - Resolve CBars via SigOpEtq + SigOpEta (renomeadas)
    * Retorna 0 se invalido, ou o CBars resolvido se encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEtiqueta(par_nCBars)
        LOCAL loc_nResultado, loc_cSQL, loc_oErro, loc_lcCBars
        loc_nResultado = 0
        TRY
            loc_lcCBars = ALLTRIM(STR(par_nCBars, 14))
            loc_cSQL = "SELECT a.CPros, a.CBars " + ;
                       "FROM SigOpEtq a " + ;
                       "LEFT JOIN SigOpEta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                       "WHERE (a.CBars = " + loc_lcCBars + ;
                       " OR b.cbars_old = " + loc_lcCBars + ")"
            IF USED("cursor_4c_EtiqTemp")
                USE IN cursor_4c_EtiqTemp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtiqTemp") > 0
                SELECT cursor_4c_EtiqTemp
                GO TOP
                IF !EOF("cursor_4c_EtiqTemp")
                    loc_nResultado = cursor_4c_EtiqTemp.CBars
                ENDIF
                USE IN cursor_4c_EtiqTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar etiqueta")
        ENDTRY
        RETURN loc_nResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEtiquetaCadastrada - Confirma existencia de CBars em SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEtiquetaCadastrada(par_nCBars)
        LOCAL loc_lExiste, loc_cSQL, loc_oErro
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 CBars FROM SigOpEtq " + ;
                       "WHERE CBars = " + ALLTRIM(STR(par_nCBars, 14))
            IF USED("cursor_4c_EtiqCheck")
                USE IN cursor_4c_EtiqCheck
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtiqCheck") > 0
                SELECT cursor_4c_EtiqCheck
                loc_lExiste = !EOF("cursor_4c_EtiqCheck")
                USE IN cursor_4c_EtiqCheck
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar etiqueta")
        ENDTRY
        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL de filtros sem persistencia em tabela propria.
    * Valida parametros minimos e registra auditoria da operacao (Consulta/Impressao).
    * Nao ha INSERT em base porque o legado usa SigOpIpE via variaveis PRIVATE
    * e a acao efetiva do form eh disparar consulta/impressao para SigCdPro/SigOpEtq.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("CONSULTA_ETIQUETA")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar filtros de estoque")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL: re-executa consulta com filtros atualizados.
    * Nao ha UPDATE em base porque nao existe tabela primaria (form de filtros).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("REEXECUCAO_FILTRO")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar filtros de estoque")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Verifica coerencia minima dos filtros do form operacional.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                MsgAviso("Data Final deve ser maior ou igual a Data Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND THIS.this_nEtiqIni > 0 AND THIS.this_nEtiqFim > 0
            IF THIS.this_nEtiqFim < THIS.this_nEtiqIni
                MsgAviso("Etiqueta Final deve ser maior ou igual a Etiqueta Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        IF loc_lValido AND !EMPTY(THIS.this_nNumero) AND !EMPTY(THIS.this_nNumerof)
            IF THIS.this_nNumerof < THIS.this_nNumero
                MsgAviso("N" + CHR(250) + "mero Final deve ser maior ou igual ao N" + CHR(250) + "mero Inicial.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao do form em LogAuditoria (SQL Server).
    * Como nao ha chave primaria, usa hash textual dos filtros como identificador.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cDetalhe, loc_oErro
        TRY
            loc_cDetalhe = "Emp=" + ALLTRIM(THIS.this_cCdEmpresa) + ;
                           " Prod=" + ALLTRIM(THIS.this_cCodProduto) + ;
                           " Grp=" + ALLTRIM(THIS.this_cCgru) + ;
                           " Est=" + ALLTRIM(THIS.this_cCdEstoque) + ;
                           " DtI=" + DTOC(THIS.this_dDtInicial) + ;
                           " DtF=" + DTOC(THIS.this_dDtFinal) + ;
                           " EtqI=" + ALLTRIM(STR(THIS.this_nEtiqIni, 14)) + ;
                           " EtqF=" + ALLTRIM(STR(THIS.this_nEtiqFim, 14))
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Tabela, ChaveRegistro, Operacao, DadosNovos) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("SigPrRet") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(LEFT(loc_cDetalhe, 500)) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
        ENDTRY
    ENDPROC

ENDDEFINE
