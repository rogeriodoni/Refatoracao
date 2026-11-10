*====================================================================
* SigOpMetBO.prg
*
* Business Object para Cadastro de Metas por Loja
* Tabela: SigOpMet
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpMetBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigOpMet)
    this_cCodigo    = ""    && codigo   char(10)    - PK
    this_cUfs       = ""    && ufs      char(2)
    this_cEmps      = ""    && emps     char(3)
    this_nCodEmps   = 0     && codemps  numeric(4,0)
    this_cNomeLoja  = ""    && nomeloja char(40)
    this_dDatas     = {}    && datas    datetime
    this_nValMeta   = 0     && valmeta  numeric(10,2)
    this_nValMetaD  = 0     && valmetad numeric(10,2)
    this_cUsuAlts   = ""    && usualts  char(10)
    this_dDtAlts    = {}    && dtalts   datetime

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpMet"
            THIS.this_cCampoChave = "codigo"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo       = TratarNulo(codigo,   "")
                THIS.this_cUfs          = TratarNulo(ufs,      "")
                THIS.this_cEmps         = TratarNulo(emps,     "")
                THIS.this_nCodEmps      = TratarNulo(codemps,  0)
                THIS.this_cNomeLoja     = TratarNulo(nomeloja, "")
                THIS.this_dDatas        = TratarNulo(datas,    {})
                THIS.this_nValMeta      = TratarNulo(valmeta,  0)
                THIS.this_nValMetaD     = TratarNulo(valmetad, 0)
                THIS.this_cUsuAlts      = TratarNulo(usualts,  "")
                THIS.this_dDtAlts       = TratarNulo(dtalts,   {})
                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigOpMet
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsuAlts = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_dDtAlts  = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpMet (codigo, ufs, emps, codemps, nomeloja, datas, valmeta, valmetad, usualts, dtalts)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cUfs)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodEmps, 0)>>,
                    <<EscaparSQL(THIS.this_cNomeLoja)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<FormatarNumeroSQL(THIS.this_nValMeta, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValMetaD, 2)>>,
                    <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    <<FormatarDataSQL(THIS.this_dDtAlts)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir meta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigOpMet
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsuAlts = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_dDtAlts  = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpMet
                SET ufs      = <<EscaparSQL(THIS.this_cUfs)>>,
                    emps     = <<EscaparSQL(THIS.this_cEmps)>>,
                    codemps  = <<FormatarNumeroSQL(THIS.this_nCodEmps, 0)>>,
                    nomeloja = <<EscaparSQL(THIS.this_cNomeLoja)>>,
                    datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    valmeta  = <<FormatarNumeroSQL(THIS.this_nValMeta, 2)>>,
                    valmetad = <<FormatarNumeroSQL(THIS.this_nValMetaD, 2)>>,
                    usualts  = <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    dtalts   = <<FormatarDataSQL(THIS.this_dDtAlts)>>
                WHERE codigo = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar meta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigOpMet
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpMet WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir meta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com as colunas da grade da Lista (pColuna do
    * Init legado): codigo, ufs, emps, nomeloja, datas, valmeta, valmetad,
    * usualts, dtalts. codemps entra tambem (usado pelo lookup de loja).
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigo C(10), ufs C(2), emps C(3), codemps N(4,0), nomeloja C(40), datas T, valmeta N(10,2), valmetad N(10,2), usualts C(10), dtalts T)
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigo, ufs, emps, codemps, nomeloja, datas," + ;
                    " valmeta, valmetad, usualts, dtalts FROM SigOpMet"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigo"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar metas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigo)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, ufs, emps, codemps, nomeloja, datas, valmeta, valmetad, usualts, dtalts" + ;
                " FROM SigOpMet WHERE codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Meta n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar meta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
