*==============================================================================
* SIGPRVTXBO.prg - Business Object para Cadastro de Testes / Importacao de
* SKU para VTEX (SIGPRVTX)
* Tabela Principal: SigPrVtx (PK: cidchaves)
*
* SIGPRVTX importa uma planilha Excel com SKUs para um cursor de grade
* (csGrade no legado) e, ao Processar/Salvar, substitui TODO o conteudo
* da tabela SigPrVtx pelo conteudo da grade (Delete From SigPrVtx + Insert
* de cada linha com cidchaves gerado por fUniqueIds()).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS SIGPRVTXBO AS BusinessBase

    *-- Propriedades: SigPrVtx
    this_cCidChaves    = ""   && cidchaves   char(20)  NOT NULL - PK (fUniqueIds())
    this_cNomeSku      = ""   && nomesku     char(100) NOT NULL
    this_cRefSku       = ""   && refsku      char(40)  NOT NULL
    this_cSkuAtivo     = ""   && skuativo    char(3)   NOT NULL
    this_cSkuId        = ""   && skuid       char(10)  NOT NULL
    this_cCpros        = ""   && cpros       char(14)  NOT NULL
    this_cDescritivo   = ""   && descritivo  char(45)  NOT NULL
    this_cTamanho      = ""   && tamanho     char(4)   NOT NULL
    this_nQtd          = 0    && qtd         numeric(11,3) NOT NULL
    this_nBxQtd        = 0    && bxqtd       numeric(11,3) NOT NULL
    this_lChkAtuStock  = .F.  && chkatustock bit NULL
    this_nPvens        = 0    && pvens       numeric(11,5) NOT NULL
    this_nPrecoDe      = 0    && precode     numeric(11,5) NOT NULL
    this_lCkVtexUp     = .F.  && ckvtexup    bit NULL
    this_lCkAtuDesc    = .F.  && ckatudesc   bit NULL
    this_nVtexProdId   = 0    && vtexProdId  int NULL

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPrVtx"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta as propriedades do BO para os valores padrao
    * CRITICO: NovoRegistro() chama LimparDados() mas a base so limpa
    * this_cMensagemErro - sem este override, this_cCidChaves sobrevive entre
    * chamadas e o Inserir() reaproveita a MESMA chave em todas as linhas da
    * grade (regra do Problema 22/#22 - fUniqueIds() so gera quando a chave
    * esta vazia)
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves   = ""
        THIS.this_cNomeSku     = ""
        THIS.this_cRefSku      = ""
        THIS.this_cSkuAtivo    = ""
        THIS.this_cSkuId       = ""
        THIS.this_cCpros       = ""
        THIS.this_cDescritivo  = ""
        THIS.this_cTamanho     = ""
        THIS.this_nQtd         = 0
        THIS.this_nBxQtd       = 0
        THIS.this_lChkAtuStock = .F.
        THIS.this_nPvens       = 0
        THIS.this_nPrecoDe     = 0
        THIS.this_lCkVtexUp    = .F.
        THIS.this_lCkAtuDesc   = .F.
        THIS.this_nVtexProdId  = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves   = TratarNulo(cidchaves,  "C")
                THIS.this_cNomeSku     = TratarNulo(nomesku,    "C")
                THIS.this_cRefSku      = TratarNulo(refsku,     "C")
                THIS.this_cSkuAtivo    = TratarNulo(skuativo,   "C")
                THIS.this_cSkuId       = TratarNulo(skuid,      "C")
                THIS.this_cCpros       = TratarNulo(cpros,      "C")
                THIS.this_cDescritivo  = TratarNulo(descritivo, "C")
                THIS.this_cTamanho     = TratarNulo(tamanho,    "C")
                THIS.this_nQtd         = TratarNulo(qtd,        "N")
                THIS.this_nBxQtd       = TratarNulo(bxqtd,      "N")
                THIS.this_nPvens       = TratarNulo(pvens,      "N")
                THIS.this_nPrecoDe     = TratarNulo(precode,    "N")
                THIS.this_nVtexProdId  = TratarNulo(vtexProdId, "N")

                IF VARTYPE(chkatustock) = "L"
                    THIS.this_lChkAtuStock = chkatustock
                ELSE
                    THIS.this_lChkAtuStock = (NVL(chkatustock, 0) = 1)
                ENDIF

                IF VARTYPE(ckvtexup) = "L"
                    THIS.this_lCkVtexUp = ckvtexup
                ELSE
                    THIS.this_lCkVtexUp = (NVL(ckvtexup, 0) = 1)
                ENDIF

                IF VARTYPE(ckatudesc) = "L"
                    THIS.this_lCkAtuDesc = ckatudesc
                ELSE
                    THIS.this_lCkAtuDesc = (NVL(ckatudesc, 0) = 1)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SIGPRVTXBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigPrVtx
    * cidchaves eh a PK Fortyus, gerada por fUniqueIds() - NUNCA string vazia
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrVtx (cidchaves, nomesku, refsku, skuativo, skuid,
                    cpros, descritivo, tamanho, qtd, bxqtd, chkatustock,
                    pvens, precode, ckvtexup, ckatudesc, vtexProdId)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cNomeSku)>>,
                    <<EscaparSQL(THIS.this_cRefSku)>>,
                    <<EscaparSQL(THIS.this_cSkuAtivo)>>,
                    <<EscaparSQL(THIS.this_cSkuId)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cDescritivo)>>,
                    <<EscaparSQL(THIS.this_cTamanho)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtd, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nBxQtd, 3)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lChkAtuStock, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPvens, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nPrecoDe, 5)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lCkVtexUp, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lCkAtuDesc, 1, 0), 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nVtexProdId, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir SKU:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SIGPRVTXBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigPrVtx
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrVtx
                SET nomesku     = <<EscaparSQL(THIS.this_cNomeSku)>>,
                    refsku      = <<EscaparSQL(THIS.this_cRefSku)>>,
                    skuativo    = <<EscaparSQL(THIS.this_cSkuAtivo)>>,
                    skuid       = <<EscaparSQL(THIS.this_cSkuId)>>,
                    cpros       = <<EscaparSQL(THIS.this_cCpros)>>,
                    descritivo  = <<EscaparSQL(THIS.this_cDescritivo)>>,
                    tamanho     = <<EscaparSQL(THIS.this_cTamanho)>>,
                    qtd         = <<FormatarNumeroSQL(THIS.this_nQtd, 3)>>,
                    bxqtd       = <<FormatarNumeroSQL(THIS.this_nBxQtd, 3)>>,
                    chkatustock = <<FormatarNumeroSQL(IIF(THIS.this_lChkAtuStock, 1, 0), 0)>>,
                    pvens       = <<FormatarNumeroSQL(THIS.this_nPvens, 5)>>,
                    precode     = <<FormatarNumeroSQL(THIS.this_nPrecoDe, 5)>>,
                    ckvtexup    = <<FormatarNumeroSQL(IIF(THIS.this_lCkVtexUp, 1, 0), 0)>>,
                    ckatudesc   = <<FormatarNumeroSQL(IIF(THIS.this_lCkAtuDesc, 1, 0), 0)>>,
                    vtexProdId  = <<FormatarNumeroSQL(THIS.this_nVtexProdId, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar SKU:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SIGPRVTXBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigPrVtx
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrVtx WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir SKU:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SIGPRVTXBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirTodos - Apaga TODO o conteudo de SigPrVtx
    * Espelha "Delete From SigPrVtx" do legado (Grupo_Botao.cmdok.Click),
    * usado antes de regravar a grade inteira a partir do cursor importado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirTodos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrVtx"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao limpar SigPrVtx:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao limpar SigPrVtx:" + CHR(13) + loException.Message, "SIGPRVTXBO.ExcluirTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, nomesku, refsku, skuativo, skuid, cpros," + ;
                " descritivo, tamanho, qtd, bxqtd, chkatustock, pvens, precode," + ;
                " ckvtexup, ckatudesc, vtexProdId" + ;
                " FROM SigPrVtx WHERE cidchaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("SKU n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar SKU:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SIGPRVTXBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
