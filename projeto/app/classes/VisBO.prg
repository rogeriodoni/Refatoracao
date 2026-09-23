*====================================================================
* VisBO.prg
*
* Business Object para Cadastro de Visitas de Representantes
* Tabela: SigCdVis
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS VisBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdVis)
    this_cChave          = ""    && pkidchave char(20) - PK
    this_dData           = {}    && datas datetime
    this_cGrupo          = ""    && grupos char(10)
    this_cContas         = ""    && contas char(10) - codigo do representante
    this_cConta          = ""    && iclis char(10) - codigo da conta
    this_nVendas         = 0     && vendas numeric(1,0)
    this_nPedidos        = 0     && pedidos numeric(1,0)
    this_cObservacao     = ""    && obss text
    this_dDataAlteracao  = {}    && dtalts datetime

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdVis"
            THIS.this_cCampoChave = "pkidchave"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "VisBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave)
    ENDFUNC

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
                THIS.this_cChave         = TratarNulo(pkidchave, "C")
                THIS.this_dData          = TratarNulo(datas,     "D")
                THIS.this_cGrupo         = TratarNulo(grupos,    "C")
                THIS.this_cContas        = TratarNulo(contas,    "C")
                THIS.this_cConta         = TratarNulo(iclis,     "C")
                THIS.this_nVendas        = TratarNulo(vendas,    "N")
                THIS.this_nPedidos       = TratarNulo(pedidos,   "N")
                THIS.this_cObservacao    = TratarNulo(obss,      "C")
                THIS.this_dDataAlteracao = TratarNulo(dtalts,    "D")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "VisBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdVis
    * pkidchave (PK) eh gerada via fUniqueIds() - o legado faz
    * "replace pkidchave with fUniqueIds() ... in crSigCdVis" no INSERIR
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cChave))
                THIS.this_cChave = fUniqueIds()
            ENDIF

            THIS.this_dDataAlteracao = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdVis (pkidchave, datas, grupos, contas, iclis, vendas, pedidos, obss, dtalts)
                VALUES (
                    <<EscaparSQL(THIS.this_cChave)>>,
                    <<FormatarDataSQL(THIS.this_dData)>>,
                    <<EscaparSQL(THIS.this_cGrupo)>>,
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<EscaparSQL(THIS.this_cConta)>>,
                    <<FormatarNumeroSQL(THIS.this_nVendas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPedidos, 0)>>,
                    <<EscaparSQL(THIS.this_cObservacao)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlteracao)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "VisBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdVis
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDataAlteracao = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdVis
                SET datas    = <<FormatarDataSQL(THIS.this_dData)>>,
                    grupos   = <<EscaparSQL(THIS.this_cGrupo)>>,
                    contas   = <<EscaparSQL(THIS.this_cContas)>>,
                    iclis    = <<EscaparSQL(THIS.this_cConta)>>,
                    vendas   = <<FormatarNumeroSQL(THIS.this_nVendas, 0)>>,
                    pedidos  = <<FormatarNumeroSQL(THIS.this_nPedidos, 0)>>,
                    obss     = <<EscaparSQL(THIS.this_cObservacao)>>,
                    dtalts   = <<FormatarDataSQL(THIS.this_dDataAlteracao)>>
                WHERE pkidchave = <<EscaparSQL(THIS.this_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "VisBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdVis
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdVis WHERE pkidchave = " + EscaparSQL(THIS.this_cChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "VisBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros para o Grid da Lista
    * Retorna cursor_4c_Dados com a.* (SigCdVis) + Descri (conta), Repr (representante),
    * DescVendas/DescPedidos (Sim/Nao) - espelha EXATAMENTE o AddCursor/pColuna do legado
    * (SigCdVis.Init, query lcQryVis)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkidchave C(20), Datas T, Grupos C(10), ;
                        Contas C(10), Iclis C(10), Vendas N(1,0), Pedidos N(1,0), Obss M, ;
                        Dtalts T, Descri C(40), Repr C(40), DescVendas C(3), DescPedidos C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.*, b.rclis AS Descri, c.rclis AS Repr," + ;
                    " CASE WHEN a.vendas = 1 THEN 'Sim' ELSE 'N" + CHR(227) + "o' END AS DescVendas," + ;
                    " CASE WHEN a.pedidos = 1 THEN 'Sim' ELSE 'N" + CHR(227) + "o' END AS DescPedidos" + ;
                    " FROM SigCdVis a" + ;
                    " INNER JOIN SigCdCli b ON a.iclis = b.iclis" + ;
                    " INNER JOIN SigCdCli c ON a.Contas = c.iclis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.pkidchave"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar visitas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "VisBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (pkidchave)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkidchave, datas, grupos, contas, iclis, vendas, pedidos, obss, dtalts" + ;
                " FROM SigCdVis WHERE pkidchave = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Visita n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "VisBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
