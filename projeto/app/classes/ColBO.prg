*------------------------------------------------------------------------------
* ColBO.prg - Business Object para Cadastro de Grupo de Venda
* Tabela: SigCdCol | PK: colecoes
* Herda de: BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS ColBO AS BusinessBase

    *-- Propriedades mapeadas da tabela SigCdCol (schema.sql)
    *-- colecoes char(10) NOT NULL (PK)
    this_cColecoes  = ""
    *-- descs char(40) NOT NULL
    this_cDescs     = ""
    *-- codcols char(1) NOT NULL
    this_cCodcols   = ""
    *-- repoauts numeric(1,0) NOT NULL
    this_nRepoauts  = 0
    *-- conprods numeric(1,0) NOT NULL
    this_nConprods  = 0
    *-- altprods numeric(1,0) NOT NULL
    this_nAltProds  = 0
    *-- dtincs datetime NULL
    this_tDtIncs    = {}
    *-- usuars char(10) NOT NULL
    this_cUsuars    = ""
    *-- agrupas char(10) NOT NULL
    this_cAgrupas   = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCol"
            THIS.this_cCampoChave = "colecoes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ColBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cColecoes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cColecoes  = TratarNulo(colecoes, "C")
                THIS.this_cDescs     = TratarNulo(descs,    "C")
                THIS.this_cCodcols   = TratarNulo(codcols,  "C")
                THIS.this_nRepoauts  = TratarNulo(repoauts, "N")
                THIS.this_nConprods  = TratarNulo(conprods, "N")
                THIS.this_nAltProds  = TratarNulo(altprods, "N")
                THIS.this_tDtIncs    = TratarNulo(dtincs,   "T")
                THIS.this_cUsuars    = TratarNulo(usuars,   "C")
                THIS.this_cAgrupas   = TratarNulo(agrupas,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "ColBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cColecoes)
            MsgAviso("Grupo de Venda Inv" + CHR(225) + "lido.")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Definir usuario e data/hora de inclusao automaticamente
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_tDtIncs = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCol (colecoes, descs, codcols, repoauts, conprods, altprods, dtincs, usuars, agrupas)
                VALUES (
                    <<EscaparSQL(THIS.this_cColecoes)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<EscaparSQL(THIS.this_cCodcols)>>,
                    <<FormatarNumeroSQL(THIS.this_nRepoauts, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nConprods, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAltProds, 0)>>,
                    GETDATE(),
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cAgrupas)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "ColBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCol
                SET descs    = <<EscaparSQL(THIS.this_cDescs)>>,
                    codcols  = <<EscaparSQL(THIS.this_cCodcols)>>,
                    repoauts = <<FormatarNumeroSQL(THIS.this_nRepoauts, 0)>>,
                    conprods = <<FormatarNumeroSQL(THIS.this_nConprods, 0)>>,
                    altprods = <<FormatarNumeroSQL(THIS.this_nAltProds, 0)>>,
                    agrupas  = <<EscaparSQL(THIS.this_cAgrupas)>>
                WHERE colecoes = <<EscaparSQL(THIS.this_cColecoes)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "ColBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCol
    * Verifica dependencia em SigCdPro antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se produtos utilizam este grupo de venda
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPro WHERE Colecoes = " + ;
                EscaparSQL(THIS.this_cColecoes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkPro")
                SELECT cursor_4c_ChkPro
                loc_nUso = cursor_4c_ChkPro.qtd
                USE IN cursor_4c_ChkPro
                IF loc_nUso > 0
                    MsgAviso("Existem Produtos Utilizando Esse Grupo de Venda.")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCol WHERE colecoes = " + ;
                        EscaparSQL(THIS.this_cColecoes)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ELSE
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "ColBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colecoes, descs, codcols
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (colecoes C(10), descs C(40), codcols C(1))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT colecoes, descs, codcols FROM SigCdCol"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY colecoes"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar grupos de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ColBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT colecoes, descs, codcols, repoauts, conprods, altprods," + ;
                " dtincs, usuars, agrupas" + ;
                " FROM SigCdCol WHERE colecoes = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de Venda n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ColBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoColetor - Verifica se codcols ja existe em outro registro
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoColetor(par_cCodcols)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF !EMPTY(par_cCodcols)
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCol" + ;
                    " WHERE codcols = " + EscaparSQL(par_cCodcols) + ;
                    " AND colecoes <> " + EscaparSQL(THIS.this_cColecoes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                    SELECT cursor_4c_ChkCod
                    loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                    USE IN cursor_4c_ChkCod
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo coletor:" + CHR(13) + loException.Message, "ColBO.VerificarCodigoColetor")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarColecaoExistente - Verifica se colecoes ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarColecaoExistente(par_cColecoes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCol" + ;
                " WHERE colecoes = " + EscaparSQL(par_cColecoes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCol")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCol")
                SELECT cursor_4c_ChkCol
                loc_lExiste = (cursor_4c_ChkCol.qtd > 0)
                USE IN cursor_4c_ChkCol
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "ColBO.VerificarColecaoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE
