*------------------------------------------------------------------------------
* crpBO.prg - Business Object para Cadastro de Caracteristicas
* Tabela: SigCrRaP | PK: Codigos
* Herda de: BusinessBase
* nTipos: 0=Produtos, 1=Contas, 2=Movimentacoes
*------------------------------------------------------------------------------

DEFINE CLASS crpBO AS BusinessBase

    *-- Propriedades mapeadas da tabela SIGCRRAP (schema.sql)
    *-- codigos char(20) NOT NULL (PK)
    this_cCodigos     = ""
    *-- descrs char(40) NOT NULL
    this_cDescrs      = ""
    *-- impetqs numeric(1,0) NOT NULL
    this_nImpetqs     = 0
    *-- ordens numeric(6,0) NOT NULL
    this_nOrdens      = 0
    *-- ntipos numeric(1,0) NOT NULL (0=Produto, 1=Conta, 2=Movimentacao)
    this_nTipos       = 0
    *-- cgrus char(3) NOT NULL (FK -> SigCdGrp ou SigCdGpr conforme nTipos)
    this_cCgrus       = ""
    *-- cidchaves char(20) NOT NULL (chave interna unica)
    this_cCidchaves   = ""
    *-- chkobrig numeric(1,0) NOT NULL DEFAULT(0)
    this_nChkobrig    = 0
    *-- dgrus: descricao do grupo (calculada via JOIN, nao armazenada na tabela)
    this_cDgrus       = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCrRaP"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "crpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * Cursores de Buscar/CarregarPorCodigo sempre incluem dgrus via JOIN
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos     = TratarNulo(codigos,   "C")
                THIS.this_cDescrs      = TratarNulo(descrs,    "C")
                THIS.this_nImpetqs     = TratarNulo(impetqs,   "N")
                THIS.this_nOrdens      = TratarNulo(ordens,    "N")
                THIS.this_nTipos       = TratarNulo(ntipos,    "N")
                THIS.this_cCgrus       = TratarNulo(cgrus,     "C")
                THIS.this_cCidchaves   = TratarNulo(cidchaves, "C")
                THIS.this_nChkobrig    = TratarNulo(chkobrig,  "N")
                THIS.this_cDgrus       = TratarNulo(dgrus,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "crpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Verifica: Codigos obrigatorio, Descrs obrigatorio,
    *           Codigos duplicado (INSERT), Ordens duplicada (INSERT/UPDATE)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cSQL, loc_nResultado
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            *-- Verificar se Codigos ja existe para o mesmo nTipos
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRaP" + ;
                " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                IF cursor_4c_ChkCod.qtd > 0
                    MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + " cadastrada!")
                    loc_lValido = .F.
                ENDIF
                USE IN cursor_4c_ChkCod
            ELSE
                MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND THIS.this_nOrdens > 0
            *-- Verificar se Ordem ja existe para diferente Codigos com mesmo nTipos
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRaP" + ;
                " WHERE Ordens = " + FormatarNumeroSQL(THIS.this_nOrdens, 0) + ;
                " AND Codigos <> " + EscaparSQL(THIS.this_cCodigos) + ;
                " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOrd")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOrd")
                SELECT cursor_4c_ChkOrd
                IF cursor_4c_ChkOrd.qtd > 0
                    MsgAviso("Ordem da Caracter" + CHR(237) + "stica j" + CHR(225) + " cadastrada!")
                    loc_lValido = .F.
                ENDIF
                USE IN cursor_4c_ChkOrd
            ELSE
                MostrarErro("Erro ao verificar ordem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCrRaP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves (substitui fUniqueIds do framework Fortyus)
            THIS.this_cCidchaves = LEFT(SYS(2015) + SYS(2015), 20)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCrRaP (codigos, descrs, impetqs, ordens, ntipos, cgrus, cidchaves, chkobrig)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<FormatarNumeroSQL(THIS.this_nImpetqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<EscaparSQL(THIS.this_cCgrus)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>,
                    <<FormatarNumeroSQL(THIS.this_nChkobrig, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "crpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCrRaP
    * Nao atualiza: codigos (PK), ntipos, cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCrRaP
                SET descrs   = <<EscaparSQL(THIS.this_cDescrs)>>,
                    impetqs  = <<FormatarNumeroSQL(THIS.this_nImpetqs, 0)>>,
                    ordens   = <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>,
                    cgrus    = <<EscaparSQL(THIS.this_cCgrus)>>,
                    chkobrig = <<FormatarNumeroSQL(THIS.this_nChkobrig, 0)>>
                WHERE Codigos = <<EscaparSQL(THIS.this_cCodigos)>>
                  AND nTipos  = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "crpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCrRaP
    * Para nTipos=0 (Produtos): verifica uso em sigprcar antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_nTipos = 0
                *-- Verificar se caracteristica esta sendo usada em produtos
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM sigprcar" + ;
                    " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPrCar")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkPrCar")
                    SELECT cursor_4c_ChkPrCar
                    loc_nUso = cursor_4c_ChkPrCar.qtd
                    USE IN cursor_4c_ChkPrCar
                    IF loc_nUso > 0
                        MsgAviso("Caracter" + CHR(237) + "stica sendo utilizada em Produtos!")
                        loc_lSucesso = .F.
                    ELSE
                        loc_cSQL = "DELETE FROM SigCrRaP" + ;
                            " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                            " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado >= 0
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lSucesso = .T.
                        ELSE
                            MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ELSE
                    MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                *-- Contas (nTipos=1) e Movimentacoes (nTipos=2): excluir diretamente
                loc_cSQL = "DELETE FROM SigCrRaP" + ;
                    " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                    " AND nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "crpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com: codigos, descrs, cgrus, ordens, dgrus
    * Filtra por this_nTipos e usa JOIN condicional para descricao do grupo
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (codigos C(20), descrs C(40), cgrus C(3), ordens N(6,0), dgrus C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_nTipos = 2
                    *-- Movimentacoes: JOIN com SigCdGpr (Codigos/Descs)
                    loc_cSQL = "SELECT a.Codigos, a.Descrs, a.Cgrus, a.Ordens," + ;
                        " ISNULL(b.Descs, '') AS Dgrus" + ;
                        " FROM SigCrRaP a" + ;
                        " LEFT JOIN SigCdGpr b ON a.Cgrus = b.Codigos" + ;
                        " WHERE a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                ELSE
                    *-- Produtos (0) e Contas (1): JOIN com SigCdGrp (Cgrus/Dgrus)
                    loc_cSQL = "SELECT a.Codigos, a.Descrs, a.Cgrus, a.Ordens," + ;
                        " ISNULL(b.Dgrus, '') AS Dgrus" + ;
                        " FROM SigCrRaP a" + ;
                        " LEFT JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                        " WHERE a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
                ENDIF

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " AND " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Ordens, a.Codigos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "crpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    * Faz JOIN condicional baseado em this_nTipos para obter dgrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_nTipos = 2
                *-- Movimentacoes: JOIN com SigCdGpr
                loc_cSQL = "SELECT a.codigos, a.descrs, a.impetqs, a.ordens, a.ntipos," + ;
                    " a.cgrus, a.cidchaves, a.chkobrig," + ;
                    " ISNULL(b.Descs, '') AS dgrus" + ;
                    " FROM SigCrRaP a" + ;
                    " LEFT JOIN SigCdGpr b ON a.Cgrus = b.Codigos" + ;
                    " WHERE a.Codigos = " + EscaparSQL(par_cCodigo) + ;
                    " AND a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            ELSE
                *-- Produtos e Contas: JOIN com SigCdGrp
                loc_cSQL = "SELECT a.codigos, a.descrs, a.impetqs, a.ordens, a.ntipos," + ;
                    " a.cgrus, a.cidchaves, a.chkobrig," + ;
                    " ISNULL(b.Dgrus, '') AS dgrus" + ;
                    " FROM SigCrRaP a" + ;
                    " LEFT JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                    " WHERE a.Codigos = " + EscaparSQL(par_cCodigo) + ;
                    " AND a.nTipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Caracter" + CHR(237) + "stica n" + CHR(227) + "o encontrada!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "crpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
