*==============================================================================
* sigprcomBO.prg - Business Object para Estoque M" + CHR(225) + "ximo (SigCdMax)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS sigprcomBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Tabela SigCdMax (linha corrente da grade de estoque)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && char(20) - PK
    this_cCodCores   = ""   && char(4)  - C" + CHR(243) + "digo da Cor
    this_cCodTams    = ""   && char(4)  - C" + CHR(243) + "digo do Tamanho
    this_cCPros      = ""   && char(14) - C" + CHR(243) + "digo do Produto (FK SigCdPro)
    this_cEmps       = ""   && char(3)  - Empresa
    this_cOrdems     = ""   && char(1)  - Ordem
    this_nQmaxs      = 0    && numeric(7,2) - Quantidade M" + CHR(225) + "xima
    this_cDeptos     = ""   && char(10) - Departamento (FK SigCdDpt)

    *--------------------------------------------------------------------------
    * Propriedades - Informa" + CHR(231) + CHR(245) + "es do Produto (SigCdPro - leitura)
    *--------------------------------------------------------------------------
    this_cDPros      = ""   && char(65) - Descri" + CHR(231) + CHR(227) + "o do Produto
    this_cCGrus      = ""   && char(3)  - C" + CHR(243) + "digo do Grupo
    this_cDGrus      = ""   && Descri" + CHR(231) + CHR(227) + "o do Grupo (join SigCdGrp)
    this_cIFors      = ""   && char(10) - C" + CHR(243) + "digo do Fornecedor
    this_cRClis      = ""   && Raz" + CHR(227) + "o do Fornecedor (join SigCdCli)
    this_cReffs      = ""   && char(40) - Refer" + CHR(234) + "ncia do Produto
    this_nSituas     = 0    && numeric(1,0) - Situa" + CHR(231) + CHR(227) + "o (1=ativo, 2=inativo)

    *--------------------------------------------------------------------------
    * Propriedades - Caracter" + CHR(237) + "sticas de varia" + CHR(231) + CHR(227) + "o do produto
    *--------------------------------------------------------------------------
    this_lTemCor     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Cor
    this_lTemTam     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Tamanho
    this_nTipoEstos  = 0    && Tipo de Estoque (0=sem, 1=tam, 2=cor, 3=tam+cor)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMax"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK do registro corrente (auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - L" + CHR(234) + " linha de SigCdMax de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodCores  = TratarNulo(codcores,  "C")
            THIS.this_cCodTams   = TratarNulo(codtams,   "C")
            THIS.this_cCPros     = TratarNulo(cpros,     "C")
            THIS.this_cEmps      = TratarNulo(emps,      "C")
            THIS.this_cOrdems    = TratarNulo(ordems,    "C")
            THIS.this_nQmaxs     = TratarNulo(qmaxs,     "N")
            THIS.this_cDeptos    = TratarNulo(deptos,    "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Pesquisa produtos em SigCdPro para a lista (Page1)
    * par_cFiltro: filtro livre por cpros/dpros/ifors/reffs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas, p.sgrus" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " ORDER BY p.cpros"
            ELSE
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas, p.sgrus" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " WHERE p.cpros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " OR p.ifors LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY p.cpros"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega produto + SigCdMax do produto
    * par_cCPros: c" + CHR(243) + "digo do produto
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nVarias
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado!")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                " c.rclis, p.reffs, p.situas, p.codcors, p.codtams, p.varias" + ;
                " FROM SigCdPro p" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = p.ifors" + ;
                " WHERE p.cpros = " + EscaparSQL(par_cCPros)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF !USED("cursor_4c_Produto") OR RECCOUNT("cursor_4c_Produto") = 0
                MsgErro("Produto n" + CHR(227) + "o encontrado!", "Aviso")
                loc_lResultado = .F.
            ELSE
                SELECT cursor_4c_Produto
                GO TOP

                THIS.this_cCPros     = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros     = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cCGrus     = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_cDGrus     = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_cIFors     = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cRClis     = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cReffs     = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_nSituas    = TratarNulo(situas, "N")
                THIS.this_lNovoRegistro = .F.

                loc_nVarias = TratarNulo(varias, "N")
                DO CASE
                    CASE loc_nVarias = 0
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 1
                        THIS.this_nTipoEstos = 1
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .F.
                    CASE loc_nVarias = 2
                        THIS.this_nTipoEstos = 2
                        THIS.this_lTemCor    = .T.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 3
                        THIS.this_nTipoEstos = 3
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .T.
                    OTHERWISE
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                ENDCASE

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF

                loc_lResultado = THIS.CarregarMaxPorProduto(par_cCPros)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMaxPorProduto - Carrega SigCdMax de um produto em cursor_4c_Max
    * Cria cursor local EDITAVEL (SQLEXEC retorna cursor somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMaxPorProduto(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Max")
                USE IN cursor_4c_Max
            ENDIF
            IF USED("cursor_4c_MaxTemp")
                USE IN cursor_4c_MaxTemp
            ENDIF

            loc_cSQL = "SELECT m.cidchaves, m.emps, m.qmaxs, m.codtams," + ;
                " m.codcores, m.deptos, m.ordems" + ;
                " FROM SigCdMax m" + ;
                " WHERE m.cpros = " + EscaparSQL(par_cCPros) + ;
                " ORDER BY m.emps, m.codtams, m.codcores, m.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                SET NULL ON
                CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), ordems C(1))
                SET NULL OFF

                IF USED("cursor_4c_MaxTemp") AND RECCOUNT("cursor_4c_MaxTemp") > 0
                    APPEND FROM DBF("cursor_4c_MaxTemp")
                ENDIF

                IF USED("cursor_4c_MaxTemp")
                    USE IN cursor_4c_MaxTemp
                ENDIF

                GO TOP IN cursor_4c_Max
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarMaxPorProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave               = fUniqueIds()
            THIS.this_cCidChaves     = loc_cChave

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                " VALUES (" + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(THIS.this_cCPros) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cEmps), 7) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQmaxs) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodTams), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodCores), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cDeptos), 14) + ", " + ;
                EscaparSQL(THIS.this_cOrdems) + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult < 0
                MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro de SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave do registro n" + CHR(227) + "o definida!", "Erro")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SigCdMax SET" + ;
                    " qmaxs = " + FormatarNumeroSQL(THIS.this_nQmaxs) + "," + ;
                    " codtams = " + LEFT(EscaparSQL(THIS.this_cCodTams), 8) + "," + ;
                    " codcores = " + LEFT(EscaparSQL(THIS.this_cCodCores), 8) + "," + ;
                    " deptos = " + LEFT(EscaparSQL(THIS.this_cDeptos), 14) + "," + ;
                    " emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7) + "," + ;
                    " ordems = " + EscaparSQL(THIS.this_cOrdems) + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdMax (PROTECTED)
    * Deleta por cidchaves OU por cpros+emps dependendo do contexto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF !EMPTY(THIS.this_cCidChaves)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cidchaves = " + ;
                    EscaparSQL(THIS.this_cCidChaves)
            ELSE
                IF !EMPTY(THIS.this_cCPros) AND !EMPTY(THIS.this_cEmps)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + ;
                    EscaparSQL(THIS.this_cCPros) + ;
                    " AND emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7)
            ELSE
                MsgErro("Nenhuma chave definida para exclus" + CHR(227) + "o!", "Erro")
                loc_lResultado = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cSQL)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGradeMax - Persiste cursor_4c_Max no banco (replace by delete+insert)
    * Chamado pelo form ap" + CHR(243) + "s edi" + CHR(231) + CHR(227) + "o da grade para o produto par_cCPros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGradeMax(par_cCPros)
        LOCAL loc_lResultado, loc_nResult
        LOCAL loc_cChaveNova, loc_cInsSQL
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o definido!")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Max")
            MsgErro("Cursor de estoque m" + CHR(225) + "ximo n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCPros) + ;
                " AND emps <> ''", ;
                "cursor_4c_DelAll")

            IF loc_nResult < 0
                MsgErro("Erro ao limpar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_DelAll")
                    USE IN cursor_4c_DelAll
                ENDIF

                SELECT cursor_4c_Max
                GO TOP
                loc_lResultado = .T.

                DO WHILE !EOF("cursor_4c_Max") AND loc_lResultado
                    IF !EMPTY(ALLTRIM(cursor_4c_Max.emps))
                        loc_cChaveNova = fUniqueIds()

                        loc_cInsSQL = "INSERT INTO SigCdMax" + ;
                            " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cChaveNova) + ", " + ;
                            EscaparSQL(par_cCPros) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.emps)), 7) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_Max.qmaxs) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codtams)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codcores)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.deptos)), 14) + ", " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Max.ordems)) + ;
                            ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cInsSQL, "cursor_4c_InsLinha")
                        IF loc_nResult < 0
                            MsgErro("Erro ao salvar linha de estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ELSE
                            IF USED("cursor_4c_InsLinha")
                                USE IN cursor_4c_InsLinha
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lResultado
                        SKIP IN cursor_4c_Max
                    ENDIF
                ENDDO

                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em SalvarGradeMax:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCopiaParaCursor - Popula cursor_4c_Copia com dados da empresa origem
    * para a funcionalidade de c" + CHR(243) + "pia entre empresas (cntCopia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCopiaParaCursor(par_cCPros, par_cEmpOs, par_cEmpDs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        IF EMPTY(par_cEmpOs)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Copia")
                USE IN cursor_4c_Copia
            ENDIF
            IF USED("cursor_4c_CopiaTemp")
                USE IN cursor_4c_CopiaTemp
            ENDIF

            loc_cSQL = "SELECT o.cpros AS cpros, o.emps AS emps, o.qmaxs AS qmaxs," + ;
                " o.codtams AS codtams, o.codcores AS codcores, o.deptos AS deptos," + ;
                " CASE WHEN d.cidchaves IS NOT NULL THEN 1 ELSE 0 END AS existes," + ;
                " CAST(0 AS INT) AS marcas" + ;
                " FROM SigCdMax o" + ;
                " LEFT JOIN SigCdMax d ON d.cpros = o.cpros" + ;
                " AND d.emps = " + LEFT(EscaparSQL(par_cEmpDs), 7) + ;
                " AND d.codtams = o.codtams AND d.codcores = o.codcores" + ;
                " WHERE o.emps = " + LEFT(EscaparSQL(par_cEmpOs), 7) + ;
                IIF(!EMPTY(ALLTRIM(par_cCPros)), " AND o.cpros = " + EscaparSQL(par_cCPros), "") + ;
                " ORDER BY o.codtams, o.codcores, o.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopiaTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar c" + CHR(243) + "pia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                *-- Necessario para permitir REPLACE ALL marcas no form
                SET NULL ON
                CREATE CURSOR cursor_4c_Copia (cpros C(14), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), existes N(1,0), marcas N(1,0))
                SET NULL OFF

                IF USED("cursor_4c_CopiaTemp") AND RECCOUNT("cursor_4c_CopiaTemp") > 0
                    APPEND FROM DBF("cursor_4c_CopiaTemp")
                ENDIF

                IF USED("cursor_4c_CopiaTemp")
                    USE IN cursor_4c_CopiaTemp
                ENDIF

                IF USED("cursor_4c_Copia")
                    GO TOP IN cursor_4c_Copia
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarCopiaParaCursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarMaxEntreEmpresas - Insere em SigCdMax os registros marcados do cursor
    * de c" + CHR(243) + "pia para a empresa destino
    * par_cEmpDs: empresa destino
    * par_cCursorCopia: nome do cursor com registros marcados (marcas=1, existes=0)
    *--------------------------------------------------------------------------
    PROCEDURE CopiarMaxEntreEmpresas(par_cEmpDs, par_cCursorCopia)
        LOCAL loc_lResultado, loc_nResult, loc_nCopias
        LOCAL loc_cChaveNova, loc_cCopSQL
        LOCAL loc_cCPros, loc_cEmps, loc_nQmaxs, loc_cCodTams
        LOCAL loc_cCodCores, loc_cDeptos, loc_nMarcas, loc_nExistes
        loc_lResultado = .F.
        loc_nCopias    = 0

        IF EMPTY(par_cEmpDs) OR EMPTY(par_cCursorCopia)
            MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CopiarMaxEntreEmpresas!", "Erro")
            RETURN .F.
        ENDIF

        IF !USED(par_cCursorCopia)
            MsgErro("Cursor de c" + CHR(243) + "pia n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cCursorCopia)
            GO TOP
            loc_lResultado = .T.

            DO WHILE !EOF() AND loc_lResultado
                loc_nMarcas  = TratarNulo(marcas,   "N")
                loc_nExistes = TratarNulo(existes,  "N")

                IF loc_nMarcas = 1 AND loc_nExistes = 0
                    loc_cCPros    = ALLTRIM(TratarNulo(cpros,    "C"))
                    loc_cEmps     = ALLTRIM(TratarNulo(emps,     "C"))
                    loc_nQmaxs    = TratarNulo(qmaxs,    "N")
                    loc_cCodTams  = ALLTRIM(TratarNulo(codtams,  "C"))
                    loc_cCodCores = ALLTRIM(TratarNulo(codcores, "C"))
                    loc_cDeptos   = ALLTRIM(TratarNulo(deptos,   "C"))

                    loc_cChaveNova = fUniqueIds()

                    loc_cCopSQL = "INSERT INTO SigCdMax" + ;
                        " (cpros, emps, qmaxs, codtams, codcores, cidchaves, deptos, ordems)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cCPros) + ", " + ;
                        LEFT(EscaparSQL(par_cEmpDs), 7) + ", " + ;
                        FormatarNumeroSQL(loc_nQmaxs) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodTams), 8) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodCores), 8) + ", " + ;
                        EscaparSQL(loc_cChaveNova) + ", " + ;
                        LEFT(EscaparSQL(loc_cDeptos), 14) + ", " + ;
                        "' ')"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cCopSQL, "cursor_4c_CopIns")
                    IF loc_nResult >= 0
                        loc_nCopias = loc_nCopias + 1
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                    ELSE
                        MsgErro("Erro ao copiar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF

                    SELECT (par_cCursorCopia)
                ENDIF

                IF loc_lResultado
                    SKIP
                ENDIF
            ENDDO

            IF loc_lResultado
                MsgInfo("Foram copiados " + ALLTRIM(STR(loc_nCopias)) + ;
                    " registros para " + ALLTRIM(par_cEmpDs) + "!", ;
                    "C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CopiarMaxEntreEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
