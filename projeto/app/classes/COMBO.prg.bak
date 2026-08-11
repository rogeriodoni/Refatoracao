*==============================================================================
* COMBO.prg - Business Object para Cadastro de Comissoes
* Tabela principal: SigCmCab (cabecalho)
* Tabela detalhe:   SigCmItn (itens: PRO=Produtos, VEN=Vendedores, MET=Metas)
* Fase 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS COMBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - SigCmCab (cabecalho)
    *--------------------------------------------------------------------------
    this_cCodigo    = ""    && pkchaves char(20) - PK (GUID)
    this_cDescricao = ""    && cods     char(40) - Descricao da comissao
    this_cEmps      = ""    && emps     char(3)  - Codigo empresa
    this_dDtInicio  = {}    && dtinis   datetime - Data inicio vigencia
    this_dDtFim     = {}    && dtfims   datetime - Data fim vigencia
    this_nMetaEmps  = 0     && metaemps numeric(15,2) - Meta da empresa
    this_nPctVd1    = 0     && pctvd1   numeric(5,2)  - % vendedor 1
    this_nPctVd2    = 0     && pctvd2   numeric(5,2)  - % vendedor 2
    this_cMoedas    = ""    && moedas   char(3)  - Codigo moeda
    this_cCodGerente = ""   && CodGerente char(10) - Codigo gerente

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de descricao (lookup display)
    *--------------------------------------------------------------------------
    this_cDEmps      = ""   && Descricao da empresa (SigCdEmp.Razas)
    this_cDMoedas    = ""   && Descricao da moeda   (SigCdMoe.DMoes)
    this_cGrPadVens  = ""   && Grupo padrao vendedores (config geral)
    this_cGrPadRess  = ""   && Grupo padrao responsaveis (config geral)
    this_cGrPadGers  = ""   && Grupo padrao gerentes (config geral)

    *--------------------------------------------------------------------------
    * Propriedade herdada obrigatoria
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *==========================================================================
    * Init - Inicializa o BO configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCmCab"
            THIS.this_cCampoChave = "pkchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro COMBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * Buscar - Lista registros de SigCmCab com filtro opcional por descricao
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE a.cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = "SELECT a.pkchaves, a.cods, a.emps, a.dtinis, a.dtfims," + ;
                       " a.metaemps, a.pctvd1, a.pctvd2, a.moedas, a.CodGerente," + ;
                       " ISNULL(b.Razas, '') AS Razas" + ;
                       " FROM sigcmcab a" + ;
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.cemps" + ;
                       loc_cWhere + ;
                       " ORDER BY a.cods"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo pkchaves e itens dos cursores
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cCodigo) <> "C" OR EMPTY(ALLTRIM(par_cCodigo))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.pkchaves, a.cods, a.emps, a.dtinis, a.dtfims," + ;
                       " a.metaemps, a.pctvd1, a.pctvd2, a.moedas, a.CodGerente," + ;
                       " ISNULL(b.Razas, '') AS Razas, ISNULL(c.DMoes, '') AS DMoes" + ;
                       " FROM sigcmcab a" + ;
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.cemps" + ;
                       " LEFT JOIN SigCdMoe c ON c.CMoes = a.moedas" + ;
                       " WHERE a.pkchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                    THIS.CarregarItens(par_cCodigo)
                ENDIF
            ELSE
                IF loc_nResult <= 0
                    MsgErro("Erro ao carregar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(pkchaves,   "C")
            THIS.this_cDescricao = TratarNulo(cods,       "C")
            THIS.this_cEmps      = TratarNulo(emps,       "C")
            THIS.this_dDtInicio  = TratarNulo(dtinis,     "D")
            THIS.this_dDtFim     = TratarNulo(dtfims,     "D")
            THIS.this_nMetaEmps  = TratarNulo(metaemps,   "N")
            THIS.this_nPctVd1    = TratarNulo(pctvd1,     "N")
            THIS.this_nPctVd2    = TratarNulo(pctvd2,     "N")
            THIS.this_cMoedas    = TratarNulo(moedas,     "C")
            THIS.this_cCodGerente = TratarNulo(CodGerente, "C")
            IF TYPE(par_cAliasCursor + ".Razas") = "C"
                THIS.this_cDEmps   = TratarNulo(Razas,  "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DMoes") = "C"
                THIS.this_cDMoedas = TratarNulo(DMoes,  "C")
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarItens - Carrega cursores crGrdItP, crGrdItV, crGrdItM do banco
    *==========================================================================
    PROCEDURE CarregarItens(par_cFkChaves)
        LOCAL loc_cSQL, loc_nResult

        TRY
            *-- Cursor de Produtos (PRO)
            IF USED("crGrdItP")
                ZAP IN crGrdItP
            ELSE
                SET NULL ON
                CREATE CURSOR crGrdItP (Mercs C(3), CGrus C(3), SGrus C(6), ;
                    PPctFixs N(6,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT mercs, cgrus, sgrus, ppctfixs, fkchaves, pkchaves, tipos" + ;
                       " FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves) + ;
                       " AND tipos = 'PRO'"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItP")
                TABLEREVERT(.T., "cursor_4c_ItP")
                USE IN cursor_4c_ItP
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItP")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ItP") > 0
                SELECT crGrdItP
                APPEND FROM DBF("cursor_4c_ItP")
                GO TOP IN crGrdItP
            ENDIF
            IF USED("cursor_4c_ItP")
                USE IN cursor_4c_ItP
            ENDIF

            *-- Cursor de Vendedores (VEN)
            IF USED("crGrdItV")
                ZAP IN crGrdItV
            ELSE
                SET NULL ON
                CREATE CURSOR crGrdItV (CodVens C(10), VMetas N(16,2), SalBases N(16,2), ;
                    CodResps C(10), RPctFixs N(6,2), fkChaves C(20), pkChaves C(20), ;
                    Tipos C(3), VMetItns N(6))
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT codvens, vmetas, salbases, codresps, rpctfixs, fkchaves, pkchaves, tipos, vmetitns" + ;
                       " FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves) + ;
                       " AND tipos = 'VEN'"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItV")
                TABLEREVERT(.T., "cursor_4c_ItV")
                USE IN cursor_4c_ItV
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItV")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ItV") > 0
                SELECT crGrdItV
                APPEND FROM DBF("cursor_4c_ItV")
                GO TOP IN crGrdItV
            ENDIF
            IF USED("cursor_4c_ItV")
                USE IN cursor_4c_ItV
            ENDIF

            *-- Cursor de Metas (MET)
            IF USED("crGrdItM")
                ZAP IN crGrdItM
            ELSE
                SET NULL ON
                CREATE CURSOR crGrdItM (CodFaixas N(2), FxaInis N(16,2), FxaFims N(16,2), ;
                    PctFaixas N(16,2), Bonus N(16,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT codfaixas, fxainis, fxafims, pctfaixas, bonus, fkchaves, pkchaves, tipos" + ;
                       " FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves) + ;
                       " AND tipos = 'MET' ORDER BY codfaixas"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItM")
                TABLEREVERT(.T., "cursor_4c_ItM")
                USE IN cursor_4c_ItM
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItM")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ItM") > 0
                SELECT crGrdItM
                APPEND FROM DBF("cursor_4c_ItM")
                GO TOP IN crGrdItM
            ENDIF
            IF USED("cursor_4c_ItM")
                USE IN cursor_4c_ItM
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.CarregarItens: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SalvarItens - Grava cursores crGrdItP/crGrdItV/crGrdItM em SigCmItn
    *==========================================================================
    PROTECTED PROCEDURE SalvarItens(par_cFkChaves)
        LOCAL loc_cSQL, loc_nResult, loc_cPk

        *-- Apaga itens anteriores
        loc_cSQL = "DELETE FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nResult < 0
            MsgErro("Erro ao limpar itens: " + CapturarErroSQL(), "Erro SQL")
            RETURN
        ENDIF

        *-- Salva Produtos (PRO)
        IF USED("crGrdItP")
            SELECT crGrdItP
            GO TOP IN crGrdItP
            SCAN FOR !DELETED()
                IF !EMPTY(ALLTRIM(crGrdItP.Mercs)) OR !EMPTY(ALLTRIM(crGrdItP.CGrus))
                    loc_cPk = crGrdItP.pkChaves
                    IF EMPTY(ALLTRIM(loc_cPk))
                        loc_cPk = fUniqueIds()
                    ENDIF
                    loc_cSQL = "INSERT INTO sigcmitn" + ;
                               " (pkchaves, fkchaves, tipos, mercs, cgrus, sgrus, ppctfixs," + ;
                               "  codvens, vmetas, salbases, codresps, rpctfixs, vmetitns," + ;
                               "  codfaixas, fxainis, fxafims, pctfaixas, bonus, formas, CodRepr)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cPk) + ", " + ;
                               EscaparSQL(par_cFkChaves) + ", " + ;
                               "'PRO', " + ;
                               EscaparSQL(ALLTRIM(crGrdItP.Mercs)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrdItP.CGrus)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrdItP.SGrus)) + ", " + ;
                               FormatarNumeroSQL(crGrdItP.PPctFixs) + ", " + ;
                               "'', 0, 0, '', 0, 0, NULL, 0, 0, 0, 0, '', '')"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
            ENDSCAN
        ENDIF

        *-- Salva Vendedores (VEN)
        IF USED("crGrdItV")
            SELECT crGrdItV
            GO TOP IN crGrdItV
            SCAN FOR !DELETED()
                IF !EMPTY(ALLTRIM(crGrdItV.CodVens))
                    loc_cPk = crGrdItV.pkChaves
                    IF EMPTY(ALLTRIM(loc_cPk))
                        loc_cPk = fUniqueIds()
                    ENDIF
                    loc_cSQL = "INSERT INTO sigcmitn" + ;
                               " (pkchaves, fkchaves, tipos, mercs, cgrus, sgrus, ppctfixs," + ;
                               "  codvens, vmetas, salbases, codresps, rpctfixs, vmetitns," + ;
                               "  codfaixas, fxainis, fxafims, pctfaixas, bonus, formas, CodRepr)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cPk) + ", " + ;
                               EscaparSQL(par_cFkChaves) + ", " + ;
                               "'VEN', " + ;
                               "'', '', '', 0, " + ;
                               EscaparSQL(ALLTRIM(crGrdItV.CodVens)) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.VMetas) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.SalBases) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrdItV.CodResps)) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.RPctFixs) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.VMetItns) + ", " + ;
                               "NULL, 0, 0, 0, 0, '', '')"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
            ENDSCAN
        ENDIF

        *-- Salva Metas (MET)
        IF USED("crGrdItM")
            SELECT crGrdItM
            GO TOP IN crGrdItM
            SCAN FOR !DELETED()
                loc_cPk = crGrdItM.pkChaves
                IF EMPTY(ALLTRIM(loc_cPk))
                    loc_cPk = fUniqueIds()
                ENDIF
                loc_cSQL = "INSERT INTO sigcmitn" + ;
                           " (pkchaves, fkchaves, tipos, mercs, cgrus, sgrus, ppctfixs," + ;
                           "  codvens, vmetas, salbases, codresps, rpctfixs, vmetitns," + ;
                           "  codfaixas, fxainis, fxafims, pctfaixas, bonus, formas, CodRepr)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cPk) + ", " + ;
                           EscaparSQL(par_cFkChaves) + ", " + ;
                           "'MET', " + ;
                           "'', '', '', 0, '', 0, 0, '', 0, 0, " + ;
                           FormatarNumeroSQL(crGrdItM.CodFaixas) + ", " + ;
                           FormatarNumeroSQL(crGrdItM.FxaInis) + ", " + ;
                           FormatarNumeroSQL(crGrdItM.FxaFims) + ", " + ;
                           FormatarNumeroSQL(crGrdItM.PctFaixas) + ", " + ;
                           FormatarNumeroSQL(crGrdItM.Bonus) + ", " + ;
                           "'', '')"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDSCAN
        ENDIF
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigCmCab e itens em SigCmItn
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cPk
        loc_lResultado = .F.

        TRY
            loc_cPk = fUniqueIds()
            THIS.this_cCodigo = loc_cPk

            loc_cSQL = "INSERT INTO sigcmcab" + ;
                       " (pkchaves, cods, emps, dtinis, dtfims, metaemps," + ;
                       "  pctvd1, pctvd2, moedas, CodGerente, usuars, usualts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cPk) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtInicio) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtFim) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMetaEmps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPctVd1) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPctVd2) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodGerente)) + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.SalvarItens(loc_cPk)
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigCmCab + re-insere itens em SigCmItn
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE sigcmcab SET" + ;
                       " cods = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                       " emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       " dtinis = " + FormatarDataSQL(THIS.this_dDtInicio) + ", " + ;
                       " dtfims = " + FormatarDataSQL(THIS.this_dDtFim) + ", " + ;
                       " metaemps = " + FormatarNumeroSQL(THIS.this_nMetaEmps) + ", " + ;
                       " pctvd1 = " + FormatarNumeroSQL(THIS.this_nPctVd1) + ", " + ;
                       " pctvd2 = " + FormatarNumeroSQL(THIS.this_nPctVd2) + ", " + ;
                       " moedas = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                       " CodGerente = " + EscaparSQL(ALLTRIM(THIS.this_cCodGerente)) + ", " + ;
                       " usualts = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.SalvarItens(THIS.this_cCodigo)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigCmCab e SigCmItn
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM sigcmitn WHERE fkchaves = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM sigcmcab WHERE pkchaves = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * InicializarCursores - Cria cursores vazios para as grades de itens
    *==========================================================================
    PROCEDURE InicializarCursores()
        TRY
            IF !USED("crGrdItP")
                SET NULL ON
                CREATE CURSOR crGrdItP (Mercs C(3), CGrus C(3), SGrus C(6), ;
                    PPctFixs N(6,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ELSE
                ZAP IN crGrdItP
            ENDIF

            IF !USED("crGrdItV")
                SET NULL ON
                CREATE CURSOR crGrdItV (CodVens C(10), VMetas N(16,2), SalBases N(16,2), ;
                    CodResps C(10), RPctFixs N(6,2), fkChaves C(20), pkChaves C(20), ;
                    Tipos C(3), VMetItns N(6))
                SET NULL OFF
            ELSE
                ZAP IN crGrdItV
            ENDIF

            IF !USED("crGrdItM")
                SET NULL ON
                CREATE CURSOR crGrdItM (CodFaixas N(2), FxaInis N(16,2), FxaFims N(16,2), ;
                    PctFaixas N(16,2), Bonus N(16,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ELSE
                ZAP IN crGrdItM
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.InicializarCursores: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FecharCursores - Fecha cursores de itens ao destruir o BO
    *==========================================================================
    PROCEDURE FecharCursores()
        IF USED("crGrdItP")
            USE IN crGrdItP
        ENDIF
        IF USED("crGrdItV")
            USE IN crGrdItV
        ENDIF
        IF USED("crGrdItM")
            USE IN crGrdItM
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarConfigGeral - Carrega grupos padrao de vendedores/responsaveis
    *==========================================================================
    PROCEDURE CarregarConfigGeral()
        LOCAL loc_cSQL, loc_nResult

        TRY
            loc_cSQL = "SELECT GrPadVens, GrPadResps" + ;
                       " FROM SigCdPam"
            IF USED("cursor_4c_Cfg")
                USE IN cursor_4c_Cfg
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cfg")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Cfg") > 0
                GO TOP IN cursor_4c_Cfg
                THIS.this_cGrPadVens = ALLTRIM(cursor_4c_Cfg.GrPadVens)
                THIS.this_cGrPadRess = ALLTRIM(cursor_4c_Cfg.GrPadResps)
            ENDIF
            IF USED("cursor_4c_Cfg")
                USE IN cursor_4c_Cfg
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.CarregarConfigGeral: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
