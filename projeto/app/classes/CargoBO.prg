*==============================================================================
* CargoBO.prg - Business Object para Cargos
* Data: 2026-03-22
* Tabela: SigCdCrg | PK: ccargs | Secundaria: SigCrRcc
* Legado: SIGCDCAR.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS CargoBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdCrg)
    this_cCargo       = ""    && ccargs
    this_cDescricao   = ""    && dcargs
    this_nLimDesc     = 0     && limdescs
    this_nDescPor     = 0     && descpors
    this_nLimAcre     = 0     && limacres
    this_nAcrePor     = 0     && acrepors
    this_nVlLibPgs    = 0     && vllibpgs
    this_nVlLibCots   = 0     && vllibcots
    this_nVlLibOpes   = 0     && vllibopes
    this_nVarCots     = 0     && varcots
    this_cSenha       = "N"   && nivels
    this_cAltCots     = "N"   && altcots
    this_cLimites     = "N"   && limites
    this_cCancItens   = "N"   && CancItens
    this_cLibFpags    = "N"   && LibFpags
    this_cLibSdIns    = "N"   && LibSdIns
    this_cLibFpgs     = "N"   && LibFpgs
    this_cLibOpes     = "N"   && LibOpes
    this_cLibAltCli   = "N"   && LibAltCli
    this_cLibExPrd    = "N"   && LibExPrd
    this_cLibOpers    = "N"   && LibOpers
    this_cLibVarPeso  = "N"   && LibVarPeso
    this_nLibLeilao   = 2     && libleilaos (1=Sim, 2=Nao)
    this_nLibDupEnds  = 2     && libDupEnds
    this_nLibSldTqe   = 2     && libSldTqe
    this_nLibDupTits  = 2     && libDupTits
    this_nLibPrzes    = 2     && libPrzes
    this_cGrComis     = ""    && GrComis
    this_nComis       = 0     && comis
    this_nAComis      = 0     && AComis
    this_cFComis      = "N"   && FComis
    this_nTpComis     = 1     && Tpcomis

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCrg"
        THIS.this_cCampoChave = "ccargs"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCargo
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE PrepararNovo()
        THIS.LimparDados()
        THIS.this_lNovoRegistro = .T.
        THIS.this_cSenha        = "S"
        THIS.this_cAltCots      = "S"
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCargo      = ""
        THIS.this_cDescricao  = ""
        THIS.this_nLimDesc    = 0
        THIS.this_nDescPor    = 0
        THIS.this_nLimAcre    = 0
        THIS.this_nAcrePor    = 0
        THIS.this_nVlLibPgs   = 0
        THIS.this_nVlLibCots  = 0
        THIS.this_nVlLibOpes  = 0
        THIS.this_nVarCots    = 0
        THIS.this_cSenha      = "N"
        THIS.this_cAltCots    = "N"
        THIS.this_cLimites    = "N"
        THIS.this_cCancItens  = "N"
        THIS.this_cLibFpags   = "N"
        THIS.this_cLibSdIns   = "N"
        THIS.this_cLibFpgs    = "N"
        THIS.this_cLibOpes    = "N"
        THIS.this_cLibAltCli  = "N"
        THIS.this_cLibExPrd   = "N"
        THIS.this_cLibOpers   = "N"
        THIS.this_cLibVarPeso = "N"
        THIS.this_nLibLeilao  = 2
        THIS.this_nLibDupEnds = 2
        THIS.this_nLibSldTqe  = 2
        THIS.this_nLibDupTits = 2
        THIS.this_nLibPrzes   = 2
        THIS.this_cGrComis    = ""
        THIS.this_nComis      = 0
        THIS.this_nAComis     = 0
        THIS.this_cFComis     = "N"
        THIS.this_nTpComis    = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por PK
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT ccargs, dcargs, limdescs, descpors, limacres, acrepors, " + ;
                       "vllibpgs, vllibcots, vllibopes, varcots, nivels, altcots, limites, " + ;
                       "CancItens, LibFpags, LibSdIns, LibFpgs, LibOpes, LibAltCli, LibExPrd, " + ;
                       "LibOpers, LibVarPeso, libleilaos, libDupEnds, libSldTqe, " + ;
                       "libDupTits, libPrzes, GrComis, comis, AComis, FComis, Tpcomis " + ;
                       "FROM SigCdCrg WHERE ccargs = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF USED("cursor_4c_CargoLoad")
                USE IN cursor_4c_CargoLoad
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CargoLoad")
            IF loc_nRet > 0
                IF !EOF("cursor_4c_CargoLoad")
                    THIS.CarregarDoCursor("cursor_4c_CargoLoad")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Cargo n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCodigo)
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro SQLEXEC ao carregar cargo: " + TRANSFORM(loc_nRet)
            ENDIF
            IF USED("cursor_4c_CargoLoad")
                USE IN cursor_4c_CargoLoad
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
            IF USED("cursor_4c_CargoLoad")
                USE IN cursor_4c_CargoLoad
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cCargo      = ALLTRIM(NVL(ccargs, ""))
        THIS.this_cDescricao  = ALLTRIM(NVL(dcargs, ""))
        THIS.this_nLimDesc    = NVL(limdescs, 0)
        THIS.this_nDescPor    = NVL(descpors, 0)
        THIS.this_nLimAcre    = NVL(limacres, 0)
        THIS.this_nAcrePor    = NVL(acrepors, 0)
        THIS.this_nVlLibPgs   = NVL(vllibpgs, 0)
        THIS.this_nVlLibCots  = NVL(vllibcots, 0)
        THIS.this_nVlLibOpes  = NVL(vllibopes, 0)
        THIS.this_nVarCots    = NVL(varcots, 0)
        THIS.this_cSenha      = ALLTRIM(NVL(nivels, "N"))
        THIS.this_cAltCots    = ALLTRIM(NVL(altcots, "N"))
        THIS.this_cLimites    = ALLTRIM(NVL(limites, "N"))
        THIS.this_cCancItens  = ALLTRIM(NVL(CancItens, "N"))
        THIS.this_cLibFpags   = ALLTRIM(NVL(LibFpags, "N"))
        THIS.this_cLibSdIns   = ALLTRIM(NVL(LibSdIns, "N"))
        THIS.this_cLibFpgs    = ALLTRIM(NVL(LibFpgs, "N"))
        THIS.this_cLibOpes    = ALLTRIM(NVL(LibOpes, "N"))
        THIS.this_cLibAltCli  = ALLTRIM(NVL(LibAltCli, "N"))
        THIS.this_cLibExPrd   = ALLTRIM(NVL(LibExPrd, "N"))
        THIS.this_cLibOpers   = ALLTRIM(NVL(LibOpers, "N"))
        THIS.this_cLibVarPeso = ALLTRIM(NVL(LibVarPeso, "N"))
        THIS.this_nLibLeilao  = NVL(libleilaos, 2)
        THIS.this_nLibDupEnds = NVL(libDupEnds, 2)
        THIS.this_nLibSldTqe  = NVL(libSldTqe, 2)
        THIS.this_nLibDupTits = NVL(libDupTits, 2)
        THIS.this_nLibPrzes   = NVL(libPrzes, 2)
        THIS.this_cGrComis    = ALLTRIM(NVL(GrComis, ""))
        THIS.this_nComis      = NVL(comis, 0)
        THIS.this_nAComis     = NVL(AComis, 0)
        THIS.this_cFComis     = ALLTRIM(NVL(FComis, "N"))
        THIS.this_nTpComis    = NVL(Tpcomis, 1)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCargo)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do Cargo obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cDescricao)
            THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdCrg " + ;
                       "(ccargs, dcargs, limdescs, descpors, limacres, acrepors, " + ;
                       "vllibpgs, vllibcots, vllibopes, varcots, nivels, altcots, limites, " + ;
                       "CancItens, LibFpags, LibSdIns, LibFpgs, LibOpes, LibAltCli, LibExPrd, " + ;
                       "LibOpers, LibVarPeso, libleilaos, libDupEnds, libSldTqe, " + ;
                       "libDupTits, libPrzes, GrComis, comis, AComis, FComis, Tpcomis) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCargo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLimDesc) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDescPor) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLimAcre) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAcrePor) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlLibPgs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlLibCots) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlLibOpes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVarCots) + ", " + ;
                       EscaparSQL(THIS.this_cSenha) + ", " + ;
                       EscaparSQL(THIS.this_cAltCots) + ", " + ;
                       EscaparSQL(THIS.this_cLimites) + ", " + ;
                       EscaparSQL(THIS.this_cCancItens) + ", " + ;
                       EscaparSQL(THIS.this_cLibFpags) + ", " + ;
                       EscaparSQL(THIS.this_cLibSdIns) + ", " + ;
                       EscaparSQL(THIS.this_cLibFpgs) + ", " + ;
                       EscaparSQL(THIS.this_cLibOpes) + ", " + ;
                       EscaparSQL(THIS.this_cLibAltCli) + ", " + ;
                       EscaparSQL(THIS.this_cLibExPrd) + ", " + ;
                       EscaparSQL(THIS.this_cLibOpers) + ", " + ;
                       EscaparSQL(THIS.this_cLibVarPeso) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLibLeilao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLibDupEnds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLibSldTqe) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLibDupTits) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLibPrzes) + ", " + ;
                       EscaparSQL(THIS.this_cGrComis) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComis) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAComis) + ", " + ;
                       EscaparSQL(THIS.this_cFComis) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpComis) + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                loc_lSucesso = THIS.SalvarRcc()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("I")
                ELSE
                    THIS.this_cMensagemErro = "Erro ao salvar libera" + CHR(231) + CHR(245) + "es de pagamento"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir cargo no banco de dados"
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdCrg SET " + ;
                       "dcargs = "       + EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       "limdescs = "     + FormatarNumeroSQL(THIS.this_nLimDesc) + ", " + ;
                       "descpors = "     + FormatarNumeroSQL(THIS.this_nDescPor) + ", " + ;
                       "limacres = "     + FormatarNumeroSQL(THIS.this_nLimAcre) + ", " + ;
                       "acrepors = "     + FormatarNumeroSQL(THIS.this_nAcrePor) + ", " + ;
                       "vllibpgs = "     + FormatarNumeroSQL(THIS.this_nVlLibPgs) + ", " + ;
                       "vllibcots = "    + FormatarNumeroSQL(THIS.this_nVlLibCots) + ", " + ;
                       "vllibopes = "    + FormatarNumeroSQL(THIS.this_nVlLibOpes) + ", " + ;
                       "varcots = "      + FormatarNumeroSQL(THIS.this_nVarCots) + ", " + ;
                       "nivels = "       + EscaparSQL(THIS.this_cSenha) + ", " + ;
                       "altcots = "      + EscaparSQL(THIS.this_cAltCots) + ", " + ;
                       "limites = "      + EscaparSQL(THIS.this_cLimites) + ", " + ;
                       "CancItens = "    + EscaparSQL(THIS.this_cCancItens) + ", " + ;
                       "LibFpags = "     + EscaparSQL(THIS.this_cLibFpags) + ", " + ;
                       "LibSdIns = "     + EscaparSQL(THIS.this_cLibSdIns) + ", " + ;
                       "LibFpgs = "      + EscaparSQL(THIS.this_cLibFpgs) + ", " + ;
                       "LibOpes = "      + EscaparSQL(THIS.this_cLibOpes) + ", " + ;
                       "LibAltCli = "    + EscaparSQL(THIS.this_cLibAltCli) + ", " + ;
                       "LibExPrd = "     + EscaparSQL(THIS.this_cLibExPrd) + ", " + ;
                       "LibOpers = "     + EscaparSQL(THIS.this_cLibOpers) + ", " + ;
                       "LibVarPeso = "   + EscaparSQL(THIS.this_cLibVarPeso) + ", " + ;
                       "libleilaos = "   + FormatarNumeroSQL(THIS.this_nLibLeilao) + ", " + ;
                       "libDupEnds = "   + FormatarNumeroSQL(THIS.this_nLibDupEnds) + ", " + ;
                       "libSldTqe = "    + FormatarNumeroSQL(THIS.this_nLibSldTqe) + ", " + ;
                       "libDupTits = "   + FormatarNumeroSQL(THIS.this_nLibDupTits) + ", " + ;
                       "libPrzes = "     + FormatarNumeroSQL(THIS.this_nLibPrzes) + ", " + ;
                       "GrComis = "      + EscaparSQL(THIS.this_cGrComis) + ", " + ;
                       "comis = "        + FormatarNumeroSQL(THIS.this_nComis) + ", " + ;
                       "AComis = "       + FormatarNumeroSQL(THIS.this_nAComis) + ", " + ;
                       "FComis = "       + EscaparSQL(THIS.this_cFComis) + ", " + ;
                       "Tpcomis = "      + FormatarNumeroSQL(THIS.this_nTpComis) + ;
                       " WHERE ccargs = " + EscaparSQL(THIS.this_cCargo)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet >= 0
                *-- Delete old RCC records
                loc_cSQL = "DELETE FROM SigCrRcc WHERE Cargos = " + EscaparSQL(THIS.this_cCargo)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet >= 0
                    loc_lSucesso = THIS.SalvarRcc()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("A")
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao salvar libera" + CHR(231) + CHR(245) + "es de pagamento"
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao excluir libera" + CHR(231) + CHR(245) + "es antigas"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar cargo no banco de dados"
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Delete secondary records first
            loc_cSQL = "DELETE FROM SigCrRcc WHERE Cargos = " + EscaparSQL(THIS.this_cCargo)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet >= 0
                loc_cSQL = "DELETE FROM SigCdCrg WHERE ccargs = " + EscaparSQL(THIS.this_cCargo)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("E")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao excluir cargo do banco de dados"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir libera" + CHR(231) + CHR(245) + "es de pagamento"
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Popula cursor_4c_Dados com lista de cargos
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL, loc_cWhere
        loc_lSucesso = .F.
        TRY
            *-- Cursor placeholder garante existencia mesmo sem conexao com banco
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (ccargs C(10), dcargs C(50))
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE ccargs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                             " OR dcargs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = "SELECT ccargs, dcargs FROM SigCdCrg" + loc_cWhere + " ORDER BY ccargs"
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
            IF loc_nRet > 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTemp")
                ELSE
                    SELECT * FROM cursor_4c_DadosTemp INTO CURSOR cursor_4c_Dados READWRITE
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar cargos"
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarRcc - Salva linhas de cursor_4c_Rcc para SigCrRcc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarRcc()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cId
        loc_lSucesso = .T.
        IF !USED("cursor_4c_Rcc")
            RETURN .T.
        ENDIF
        TRY
            SELECT cursor_4c_Rcc
            SCAN
                IF !EMPTY(ALLTRIM(Grupos)) AND !EMPTY(ALLTRIM(Contas)) AND Valors > 0 AND !EMPTY(ALLTRIM(Moedas))
                    loc_cId = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 36)
                    loc_cSQL = "INSERT INTO SigCrRcc (Grupos, Contas, Valors, Moedas, Cargos, CidChaves) VALUES (" + ;
                               EscaparSQL(ALLTRIM(Grupos)) + ", " + ;
                               EscaparSQL(ALLTRIM(Contas)) + ", " + ;
                               FormatarNumeroSQL(Valors) + ", " + ;
                               EscaparSQL(ALLTRIM(Moedas)) + ", " + ;
                               EscaparSQL(ALLTRIM(THIS.this_cCargo)) + ", " + ;
                               EscaparSQL(loc_cId) + ")"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nRet < 0
                        THIS.this_cMensagemErro = "Erro ao inserir linha em SigCrRcc"
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDIF
            ENDSCAN
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
