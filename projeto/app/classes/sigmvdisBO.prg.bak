*====================================================================
* sigmvdisBO.prg
*
* Business Object para Distribuicao por Movimentacao de Produtos
* Tabela: SigPrDis
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigmvdisBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrDis)
    this_cCidChave         = ""    && cidchaves     char(20)  - PK (Fortyus)
    this_cCodigo           = ""    && codigos       char(10)  - Codigo do lote de distribuicao
    this_cCodProduto       = ""    && cpros         char(14)  - Codigo do produto
    this_cCodCor           = ""    && codcors       char(4)   - Codigo da cor
    this_cCodTamanho       = ""    && codtams       char(4)   - Codigo do tamanho
    this_dData             = {}    && datas         datetime  - Data da distribuicao
    this_dDataAlteracao    = {}    && dtalts        datetime  - Data da ultima alteracao
    this_cEmpDopNum        = ""    && empdopnums    char(29)  - Empresa+Documento+Numero de origem
    this_cOriDopNum        = ""    && oridopnums    char(29)  - Empresa+Documento+Numero original
    this_cEmpDestino       = ""    && empds         char(3)   - Empresa de destino
    this_cEmpGrupoEstab    = ""    && empgruests    char(23)  - Empresa+Grupo+Estabelecimento
    this_cLocal            = ""    && locals        char(10)  - Local de estoque
    this_nQtdOrigem        = 0     && qtdos         numeric(10,2) - Quantidade de origem
    this_nQtd              = 0     && qtds          numeric(10,2) - Quantidade distribuida
    this_cUsuario          = ""    && usuars        char(10)  - Usuario de inclusao
    this_cUsuarioAlteracao = ""    && usualts       char(10)  - Usuario de alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrDis"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigmvdisBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChave         = TratarNulo(cidchaves,  "C")
                THIS.this_cCodigo           = TratarNulo(codigos,    "C")
                THIS.this_cCodProduto       = TratarNulo(cpros,      "C")
                THIS.this_cCodCor           = TratarNulo(codcors,    "C")
                THIS.this_cCodTamanho       = TratarNulo(codtams,    "C")
                THIS.this_dData             = TratarNulo(datas,      "D")
                THIS.this_dDataAlteracao    = TratarNulo(dtalts,     "D")
                THIS.this_cEmpDopNum        = TratarNulo(empdopnums, "C")
                THIS.this_cOriDopNum        = TratarNulo(oridopnums, "C")
                THIS.this_cEmpDestino       = TratarNulo(empds,      "C")
                THIS.this_cEmpGrupoEstab    = TratarNulo(empgruests, "C")
                THIS.this_cLocal            = TratarNulo(locals,     "C")
                THIS.this_nQtdOrigem        = TratarNulo(qtdos,      "N")
                THIS.this_nQtd              = TratarNulo(qtds,       "N")
                THIS.this_cUsuario          = TratarNulo(usuars,     "C")
                THIS.this_cUsuarioAlteracao = TratarNulo(usualts,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigmvdisBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCodProduto)
            MsgAviso("Produto n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmpDestino)
            MsgAviso("Empresa de destino n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nQtd <= 0
            MsgAviso("Quantidade distribu" + CHR(237) + "da deve ser maior que zero!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrDis
    * PK Fortyus (cidchaves): gerada via fUniqueIds() - NUNCA string vazia
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChave
        loc_lSucesso = .F.

        TRY
            loc_cCidChave = IIF(EMPTY(THIS.this_cCidChave), fUniqueIds(), THIS.this_cCidChave)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrDis
                    (cidchaves, codigos, cpros, codcors, codtams,
                     datas, dtalts, empdopnums, oridopnums, empds,
                     empgruests, locals, qtdos, qtds, usuars, usualts)
                VALUES (
                    <<EscaparSQL(loc_cCidChave)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cCodProduto)>>,
                    <<EscaparSQL(THIS.this_cCodCor)>>,
                    <<EscaparSQL(THIS.this_cCodTamanho)>>,
                    <<FormatarDataSQL(THIS.this_dData)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlteracao)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNum)>>,
                    <<EscaparSQL(THIS.this_cOriDopNum)>>,
                    <<EscaparSQL(THIS.this_cEmpDestino)>>,
                    <<EscaparSQL(THIS.this_cEmpGrupoEstab)>>,
                    <<EscaparSQL(THIS.this_cLocal)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtdOrigem, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtd, 2)>>,
                    <<EscaparSQL(gc_4c_UsuarioLogado)>>,
                    <<EscaparSQL(gc_4c_UsuarioLogado)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChave = loc_cCidChave
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "sigmvdisBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrDis
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrDis
                SET codigos    = <<EscaparSQL(THIS.this_cCodigo)>>,
                    cpros      = <<EscaparSQL(THIS.this_cCodProduto)>>,
                    codcors    = <<EscaparSQL(THIS.this_cCodCor)>>,
                    codtams    = <<EscaparSQL(THIS.this_cCodTamanho)>>,
                    datas      = <<FormatarDataSQL(THIS.this_dData)>>,
                    dtalts     = <<GETDATE()>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNum)>>,
                    oridopnums = <<EscaparSQL(THIS.this_cOriDopNum)>>,
                    empds      = <<EscaparSQL(THIS.this_cEmpDestino)>>,
                    empgruests = <<EscaparSQL(THIS.this_cEmpGrupoEstab)>>,
                    locals     = <<EscaparSQL(THIS.this_cLocal)>>,
                    qtdos      = <<FormatarNumeroSQL(THIS.this_nQtdOrigem, 2)>>,
                    qtds       = <<FormatarNumeroSQL(THIS.this_nQtd, 2)>>,
                    usualts    = <<EscaparSQL(gc_4c_UsuarioLogado)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigmvdisBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrDis
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "sigmvdisBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirPorCodigo - Exclui TODOS os registros de um lote (codigos)
    * Espelha o legado: Delete From SigPrDis Where Codigos = ?_Codigo
    *====================================================================
    PROCEDURE ExcluirPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir lote de distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir lote:" + CHR(13) + loException.Message, "sigmvdisBO.ExcluirPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca lotes de distribuicao (lista distinta de Codigos/Datas)
    * Espelha o legado: Select Distinct Codigos, Datas from SigPrDis
    * Retorna cursor_4c_Dados com codigos, datas
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), datas T)
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT codigos, datas FROM SigPrDis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY datas DESC, codigos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar distribui" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "sigmvdisBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codigos, cpros, codcors, codtams," + ;
                " datas, dtalts, empdopnums, oridopnums, empds," + ;
                " empgruests, locals, qtdos, qtds, usuars, usualts" + ;
                " FROM SigPrDis WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro de distribui" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar distribui" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigmvdisBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItensPorLote - Carrega TODOS os itens de um lote (codigos)
    * Espelha o legado: Select * from SigPrDis where Codigos = ?_Codigo
    * Retorna cursor_4c_ItensLote
    *====================================================================
    PROCEDURE BuscarItensPorLote(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codigos, cpros, codcors, codtams," + ;
                " datas, dtalts, empdopnums, oridopnums, empds," + ;
                " empgruests, locals, qtdos, qtds, usuars, usualts" + ;
                " FROM SigPrDis WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_ItensLote")
                USE IN cursor_4c_ItensLote
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensLote")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "sigmvdisBO.BuscarItensPorLote")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
