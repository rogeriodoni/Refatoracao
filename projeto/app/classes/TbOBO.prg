*============================================================================
* TbOBO.prg - Business Object: Tabelas de Desconto por Operacao
* Migrado de: SIGCDTBV.SCX (SigCdTbO)
* Tabela principal   : SigOpTdo   (chave: cidchaves)
* Tabela relacionada : SigOpTdz   (tabelas de desconto - lookup/join, chave: codigos)
* Tabela pai         : SigCdOpe   (operacao, chave: dopes) - informada pelo form chamador
*============================================================================
DEFINE CLASS TbOBO AS BusinessBase

    *-- Propriedades: SigOpTdo
    this_cCidChaves = ""   && cidchaves   C(20) - Chave Primaria
    this_cDopes     = ""   && dopes       C(20) - FK SigCdOpe.Dopes (operacao pai)
    this_cTabds     = ""   && tabds       C(10) - FK SigOpTdz.Codigos (tabela de desconto)

    *-- Propriedade auxiliar: SigOpTdz (somente exibicao via JOIN, nao persistida em SigOpTdo)
    this_cDescrs    = ""   && descrs      C(30) - Descricao da tabela de desconto (JOIN SigOpTdz)

    *-- Nome do cursor local de detalhe (grid editavel de tabelas de desconto da operacao)
    this_cCursorDetalhe = "cursor_4c_TbODetalhe"

    *-- Flags de controle de alteracao (equivalentes a lHouveIns/lHouveExcl do legado)
    this_lHouveInsercao = .F.
    this_lHouveExclusao = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpTdo"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para um novo registro (chamado por
    * BusinessBase.NovoRegistro()). CRITICO: sem isso, this_cCidChaves de um
    * registro anteriormente carregado (Visualizar/Alterar/Excluir) permanece
    * preenchido e Inserir() reaproveitaria essa PK antiga em vez de gerar uma
    * nova via fUniqueIds().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves = ""
        THIS.this_cDopes     = ""
        THIS.this_cTabds     = ""
        THIS.this_cDescrs    = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT das tabelas de desconto vinculadas a operacao (JOIN SigOpTdz)
    * par_cDopes: codigo da operacao (SigCdOpe.Dopes). Se vazio, retorna TODOS os
    *             vinculos de todas as operacoes (equivalente a listagem geral).
    * Espelha exatamente a query original:
    *   Select a.*,b.Descrs From SigOpTdo a, SigOpTdz b
    *     Where a.Dopes = '<dopes>' And a.Tabds = b.Codigos
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.tabds, b.descrs" + ;
                       " FROM SigOpTdo a" + ;
                       " INNER JOIN SigOpTdz b ON a.tabds = b.codigos"

            IF VARTYPE(par_cDopes) = "C" AND !EMPTY(par_cDopes)
                loc_cSQL = loc_cSQL + ;
                    " WHERE a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.tabds"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT registro por chave primaria (cidchaves) + JOIN descrs
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.tabds, b.descrs" + ;
                       " FROM SigOpTdo a" + ;
                       " INNER JOIN SigOpTdz b ON a.tabds = b.codigos" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, "C"))
                THIS.this_cDopes     = ALLTRIM(TratarNulo(dopes, "C"))
                THIS.this_cTabds     = ALLTRIM(TratarNulo(tabds, "C"))
                *-- descrs so existe quando o SELECT fez JOIN com SigOpTdz (Buscar/CarregarPorCodigo)
                IF TYPE("descrs") = "C"
                    THIS.this_cDescrs = ALLTRIM(TratarNulo(descrs, "C"))
                ELSE
                    THIS.this_cDescrs = ""
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpTdo (todas colunas NOT NULL preenchidas)
    * Gera cidchaves automaticamente (equivalente a fUniqueIds() do legado) se
    * ainda nao tiver sido atribuido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpTdo" + ;
                       " (cidchaves, dopes, tabds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       EscaparSQL(THIS.this_cTabds) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                THIS.this_lHouveInsercao = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpTdo (dopes/tabds) WHERE cidchaves = chave
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpTdo SET" + ;
                       " dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " tabds = " + EscaparSQL(THIS.this_cTabds) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigOpTdo WHERE cidchaves = chave
    * (Chamado PUBLICAMENTE via THIS.Excluir(), nunca direto - CLAUDE.md regra BO)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpTdo WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                THIS.this_lHouveExclusao = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteVinculoDuplicado - Verifica se a Tabela de Desconto ja esta
    * vinculada a esta Operacao em OUTRO registro. Equivale a validacao de
    * duplicidade de Tabds por Dopes do cmdSair.Click do legado (que escaneava
    * toda a LocalTabdO em memoria antes de gravar em lote); aqui e aplicada no
    * momento do Salvar de cada vinculo individual (par_cCidChavesAtual exclui
    * o proprio registro em edicao, para nao se autoacusar de duplicidade).
    *--------------------------------------------------------------------------
    FUNCTION ExisteVinculoDuplicado(par_cDopes, par_cTabds, par_cCidChavesAtual)
        LOCAL loc_lExiste, loc_cSQL, loc_nResultado
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigOpTdo" + ;
                       " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                       " AND tabds = " + EscaparSQL(ALLTRIM(par_cTabds))

            IF VARTYPE(par_cCidChavesAtual) = "C" AND !EMPTY(par_cCidChavesAtual)
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(ALLTRIM(par_cCidChavesAtual))
            ENDIF

            IF USED("cursor_4c_DupVinc")
                USE IN cursor_4c_DupVinc
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupVinc")
            IF loc_nResultado >= 0
                loc_lExiste = (RECCOUNT("cursor_4c_DupVinc") > 0)
            ELSE
                MsgErro("Erro ao verificar duplicidade do v" + CHR(237) + "nculo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DupVinc")
                USE IN cursor_4c_DupVinc
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ExisteVinculoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarTabelaDescontoDuplicada - Verifica se ha Tabds repetido para a mesma
    * operacao (equivalente ao "Select Tabds,sum(1) as TT ... GROUP by 1 ... TT>1"
    * do cmdSair.Click do legado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarTabelaDescontoDuplicada(par_cDopes)
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResultado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT tabds, COUNT(*) AS Total FROM SigOpTdo" + ;
                       " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                       " GROUP BY tabds HAVING COUNT(*) > 1"

            IF USED("cursor_4c_DupChk")
                TABLEREVERT(.T., "cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_DupChk") > 0
                    loc_lDuplicado = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ValidarTabelaDescontoDuplicada:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

ENDDEFINE
