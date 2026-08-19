*==============================================================================
* LinBO.prg - Business Object para Cadastro de Linhas de Producao
* Tabela principal: SigCdLin  (PK: linhas char 10)
* Tabelas auxiliares: SigCdLnf (Fases), SigCdLni (Composicao), SigPrPrc (Comp. Obrigatoria)
*==============================================================================

DEFINE CLASS LinBO AS BusinessBase

    *-- Identificacao / Chave primaria
    this_cLinhas      = ""    && char(10)  Codigo da Linha de Producao (PK)

    *-- Descricao
    this_cDescs       = ""    && char(40)  Descricao da Linha

    *-- Codigo de coluna (campo oculto no form, usado internamente)
    this_cCodCols     = ""    && char(1)   Codigo de Coluna (codcols)

    *-- Pedido de estoque minimo - lookup em SigCdOpe (Dopes)
    this_cPedidos     = ""    && char(20)  Codigo da Operacao (FK SigCdOpe.Dopes)

    *-- Tipos de classificacao (char "1" ou "2")
    this_cTpCustos    = ""    && char(1)   Tipo de Custo  (1=Unitario / 2=Por Peso)
    this_cTpVendas    = ""    && char(1)   Tipo de Venda  (1=Unitario / 2=Por Peso)
    this_cTpPesos     = ""    && char(1)   Tipo de Peso   (1=Normal   / 2=Imagem Total)

    *-- Campos numericos de configuracao
    this_nTeors       = 0     && numeric(4,0)  Teor
    this_nBReservas   = 0     && numeric(5,2)  Base de Reservas (%)
    this_nQtPcs       = 0     && numeric(5,0)  Qtd Pecas por OF
    this_nChkPesags   = 0     && numeric(1,0)  Analisa Pesagem (1=Sim / 2=Nao)
    this_nIds         = 0     && numeric(10,0) ID interno (auto)
    this_nBonus       = 0     && numeric(1,0)  Bonus (OptionGroup fwoption1)
    this_nGerNEtiqs   = 0     && numeric(1,0)  Gerar N/Etiqs (oculto - optGerNEtiqs)
    this_nVlrFixos    = 0     && numeric(1,0)  Preco Fixo SubNivel Por Operacao (Opt_Preco)

    *-- Figura Tecnica (blob JPEG armazenado como text no banco)
    this_cFigJpgs     = ""    && text          Imagem da Figura Tecnica (figjpgs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdLin"
        THIS.this_cCampoChave = "linhas"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cLinhas
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cLinhas     = TratarNulo(linhas,     "C")
                THIS.this_cDescs      = TratarNulo(descs,      "C")
                THIS.this_cCodCols    = TratarNulo(codcols,    "C")
                THIS.this_cPedidos    = TratarNulo(pedidos,    "C")
                THIS.this_cTpCustos   = TratarNulo(tpcustos,   "C")
                THIS.this_cTpVendas   = TratarNulo(tpvendas,   "C")
                THIS.this_cTpPesos    = TratarNulo(tppesos,    "C")
                THIS.this_nTeors      = TratarNulo(teors,      "N")
                THIS.this_nBReservas  = TratarNulo(breservas,  "N")
                THIS.this_nQtPcs      = TratarNulo(qtpcs,      "N")
                THIS.this_nChkPesags  = TratarNulo(chkpesags,  "N")
                THIS.this_nIds        = TratarNulo(ids,        "N")
                THIS.this_nBonus      = TratarNulo(bonus,      "N")
                THIS.this_nGerNEtiqs  = TratarNulo(gernetiqs,  "N")
                THIS.this_nVlrFixos   = TratarNulo(vlrfixos,   "N")
                THIS.this_cFigJpgs    = TratarNulo(figjpgs,    "C")
                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar cursor: " + loException.Message, "LinBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista todas as linhas de producao
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT linhas, descs, tpcustos, tpvendas" + ;
                       " FROM SigCdLin" + ;
                       " ORDER BY linhas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar linhas: " + CapturarErroSQL(), "LinBO.Buscar")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo da linha
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cLinhas))
            RETURN .F.
        ENDIF

        TRY

            loc_cSQL = "SELECT linhas, descs, codcols, pedidos," + ;
                       " tpcustos, tpvendas, tppesos," + ;
                       " teors, breservas, qtpcs, chkpesags," + ;
                       " ids, bonus, gernetiqs, vlrfixos, figjpgs" + ;
                       " FROM SigCdLin" + ;
                       " WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar linha: " + CapturarErroSQL(), "LinBO.CarregarPorCodigo")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdLin
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdLin" + ;
                       " (linhas, descs, codcols, pedidos," + ;
                       " tpcustos, tpvendas, tppesos," + ;
                       " teors, breservas, qtpcs, chkpesags," + ;
                       " ids, bonus, gernetiqs, vlrfixos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cLinhas)    + ", " + ;
                       EscaparSQL(THIS.this_cDescs)     + ", " + ;
                       EscaparSQL(THIS.this_cCodCols)   + ", " + ;
                       EscaparSQL(THIS.this_cPedidos)   + ", " + ;
                       EscaparSQL(THIS.this_cTpCustos)  + ", " + ;
                       EscaparSQL(THIS.this_cTpVendas)  + ", " + ;
                       EscaparSQL(THIS.this_cTpPesos)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTeors)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBReservas)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtPcs)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkPesags)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nIds)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBonus)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nGerNEtiqs)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrFixos)   + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao incluir linha: " + CapturarErroSQL(), "LinBO.Inserir")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdLin
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLin SET" + ;
                       " descs       = " + EscaparSQL(THIS.this_cDescs)     + ", " + ;
                       " codcols     = " + EscaparSQL(THIS.this_cCodCols)   + ", " + ;
                       " pedidos     = " + EscaparSQL(THIS.this_cPedidos)   + ", " + ;
                       " tpcustos    = " + EscaparSQL(THIS.this_cTpCustos)  + ", " + ;
                       " tpvendas    = " + EscaparSQL(THIS.this_cTpVendas)  + ", " + ;
                       " tppesos     = " + EscaparSQL(THIS.this_cTpPesos)   + ", " + ;
                       " teors       = " + FormatarNumeroSQL(THIS.this_nTeors)     + ", " + ;
                       " breservas   = " + FormatarNumeroSQL(THIS.this_nBReservas) + ", " + ;
                       " qtpcs       = " + FormatarNumeroSQL(THIS.this_nQtPcs)     + ", " + ;
                       " chkpesags   = " + FormatarNumeroSQL(THIS.this_nChkPesags) + ", " + ;
                       " bonus       = " + FormatarNumeroSQL(THIS.this_nBonus)     + ", " + ;
                       " gernetiqs   = " + FormatarNumeroSQL(THIS.this_nGerNEtiqs) + ", " + ;
                       " vlrfixos    = " + FormatarNumeroSQL(THIS.this_nVlrFixos)  + ;
                       " WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar linha: " + CapturarErroSQL(), "LinBO.Atualizar")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdLin + cascata em SigCdLnf/SigCdLni/SigPrPrc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir fases da linha
            loc_cSQL = "DELETE FROM SigCdLnf WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir composicao de insumos
            loc_cSQL = "DELETE FROM SigCdLni WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir composicao obrigatoria
            loc_cSQL = "DELETE FROM SigPrPrc WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir a linha principal
            loc_cSQL = "DELETE FROM SigCdLin WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir linha: " + CapturarErroSQL(), "LinBO.ExecutarExclusao")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Salvar - Override: salva registro principal + tabelas de detalhe
    *--------------------------------------------------------------------------
    PROCEDURE Salvar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF DODEFAULT()
                loc_lResultado = THIS.SalvarFases(THIS.this_cLinhas)
                IF loc_lResultado
                    loc_lResultado = THIS.SalvarComposicao(THIS.this_cLinhas)
                ENDIF
                IF loc_lResultado
                    loc_lResultado = THIS.SalvarComposicaoObrigatoria(THIS.this_cLinhas)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.Salvar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFases - Popula cursor_4c_Fases (SigCdLnf + descricao SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarFases(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Fases")
            USE IN cursor_4c_Fases
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cLinhas))
                SET NULL ON
                CREATE CURSOR cursor_4c_Fases ;
                    (Linhas C(10), Ordems N(2,0), Ordem2 N(3,0), Grupos C(10), ;
                     Descrs C(40), Agregas L, Contas C(10), Cgrus C(3), ;
                     Ndias N(2,0), UniPrdts C(10), Usuars C(10), Mercs C(3), Obs M)
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.linhas, a.ordems, a.ordem2, a.grupos," + ;
                           " ISNULL(b.descrs,'') AS descrs, a.agregas," + ;
                           " a.contas, a.cgrus, a.ndias, a.uniprdts, a.usuars," + ;
                           " a.mercs, a.obs" + ;
                           " FROM SigCdLnf a" + ;
                           " LEFT JOIN SigCdGcr b ON b.codigos = a.grupos" + ;
                           " WHERE a.linhas = " + EscaparSQL(ALLTRIM(par_cLinhas)) + ;
                           " ORDER BY a.ordems, a.ordem2"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesLoad")

                IF loc_nResultado >= 0
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Fases ;
                        (Linhas C(10), Ordems N(2,0), Ordem2 N(3,0), Grupos C(10), ;
                         Descrs C(40), Agregas L, Contas C(10), Cgrus C(3), ;
                         Ndias N(2,0), UniPrdts C(10), Usuars C(10), Mercs C(3), Obs M)
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_FasesLoad") > 0
                        APPEND FROM DBF("cursor_4c_FasesLoad")
                    ENDIF
                    GO TOP IN cursor_4c_Fases

                    IF USED("cursor_4c_FasesLoad")
                        USE IN cursor_4c_FasesLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar fases: " + CapturarErroSQL(), "LinBO.BuscarFases")
                    IF USED("cursor_4c_FasesLoad")
                        USE IN cursor_4c_FasesLoad
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.BuscarFases")
            IF USED("cursor_4c_FasesLoad")
                USE IN cursor_4c_FasesLoad
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComposicao - Popula cursor_4c_Composicao (SigCdLni)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComposicao(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Composicao")
            USE IN cursor_4c_Composicao
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cLinhas))
                SET NULL ON
                CREATE CURSOR cursor_4c_Composicao ;
                    (Linhas C(10), Mats C(14), Dcompos C(30), UniCompos C(3), ;
                     Pcompos N(11,3), Qtds N(8,3), Totas N(11,3), ;
                     Moeds C(3), ObsCompos C(10), Etiqs C(1))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.linhas, a.mats, a.dcompos, a.unicompos," + ;
                           " a.pcompos, a.qtds, a.totas, a.moeds, a.obscompos, a.etiqs" + ;
                           " FROM SigCdLni a" + ;
                           " WHERE a.linhas = " + EscaparSQL(ALLTRIM(par_cLinhas)) + ;
                           " ORDER BY a.ordems, a.ordcompos"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoLoad")

                IF loc_nResultado >= 0
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Composicao ;
                        (Linhas C(10), Mats C(14), Dcompos C(30), UniCompos C(3), ;
                         Pcompos N(11,3), Qtds N(8,3), Totas N(11,3), ;
                         Moeds C(3), ObsCompos C(10), Etiqs C(1))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_CompoLoad") > 0
                        APPEND FROM DBF("cursor_4c_CompoLoad")
                    ENDIF
                    GO TOP IN cursor_4c_Composicao

                    IF USED("cursor_4c_CompoLoad")
                        USE IN cursor_4c_CompoLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar composi" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL(), "LinBO.BuscarComposicao")
                    IF USED("cursor_4c_CompoLoad")
                        USE IN cursor_4c_CompoLoad
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.BuscarComposicao")
            IF USED("cursor_4c_CompoLoad")
                USE IN cursor_4c_CompoLoad
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCompObrig - Popula cursor_4c_CompObrig (SigPrPrc)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCompObrig(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_CompObrig")
            USE IN cursor_4c_CompObrig
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cLinhas))
                SET NULL ON
                CREATE CURSOR cursor_4c_CompObrig ;
                    (Linhas C(10), Mat1s C(14), Cgrus C(3), Mercs C(3), Mat2s C(14))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.linhas, a.mat1s, a.cgrus, a.mercs, a.mat2s" + ;
                           " FROM SigPrPrc a" + ;
                           " WHERE a.linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompLoad")

                IF loc_nResultado >= 0
                    SET NULL ON
                    CREATE CURSOR cursor_4c_CompObrig ;
                        (Linhas C(10), Mat1s C(14), Cgrus C(3), Mercs C(3), Mat2s C(14))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_CompLoad") > 0
                        APPEND FROM DBF("cursor_4c_CompLoad")
                    ENDIF
                    GO TOP IN cursor_4c_CompObrig

                    IF USED("cursor_4c_CompLoad")
                        USE IN cursor_4c_CompLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar comp. obrigat" + CHR(243) + "ria: " + CapturarErroSQL(), "LinBO.BuscarCompObrig")
                    IF USED("cursor_4c_CompLoad")
                        USE IN cursor_4c_CompLoad
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.BuscarCompObrig")
            IF USED("cursor_4c_CompLoad")
                USE IN cursor_4c_CompLoad
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarFases - Persiste cursor_4c_Fases em SigCdLnf (DELETE + re-INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarFases(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroLoop, loc_cChave
        loc_lSucesso  = .F.
        loc_lErroLoop = .F.

        IF !USED("cursor_4c_Fases")
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdLnf WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar fases: " + CapturarErroSQL(), "LinBO.SalvarFases")
            ELSE
                SELECT cursor_4c_Fases
                GO TOP
                DO WHILE !EOF("cursor_4c_Fases") AND !loc_lErroLoop
                    IF !DELETED()
                        loc_cChave = LEFT(fUniqueIds(), 20)
                        loc_cSQL = "INSERT INTO SigCdLnf" + ;
                                   " (cidchaves, linhas, ordems, ordem2, grupos, cgrus, mercs," + ;
                                   "  contas, ndias, uniprdts, usuars, agregas, obs, matprdts, etiquetas)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cChave)                                   + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cLinhas))                         + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Fases.Ordems)               + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Fases.Ordem2)               + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Grupos))             + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Cgrus))              + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Mercs))              + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Contas))             + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Fases.Ndias)                + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.UniPrdts))           + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Usuars))             + ", " + ;
                                   IIF(NVL(cursor_4c_Fases.Agregas, .F.), "1", "0")       + ", " + ;
                                   EscaparSQL(ALLTRIM(NVL(cursor_4c_Fases.Obs, "")))       + ", " + ;
                                   EscaparSQL("")                                           + ", " + ;
                                   "0)"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar fase: " + CapturarErroSQL(), "LinBO.SalvarFases")
                            loc_lErroLoop = .T.
                        ENDIF
                    ENDIF
                    IF !loc_lErroLoop
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lErroLoop
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.SalvarFases")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarComposicao - Persiste cursor_4c_Composicao em SigCdLni (DELETE + re-INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarComposicao(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroLoop, loc_cChave, loc_nOrdem
        loc_lSucesso  = .F.
        loc_lErroLoop = .F.

        IF !USED("cursor_4c_Composicao")
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdLni WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar composi" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL(), "LinBO.SalvarComposicao")
            ELSE
                SELECT cursor_4c_Composicao
                GO TOP
                loc_nOrdem = 0
                DO WHILE !EOF("cursor_4c_Composicao") AND !loc_lErroLoop
                    IF !DELETED()
                        loc_nOrdem  = loc_nOrdem + 1
                        loc_cChave  = LEFT(fUniqueIds(), 20)
                        loc_cSQL = "INSERT INTO SigCdLni" + ;
                                   " (cidchaves, linhas, mats, cpros, dcompos, unicompos," + ;
                                   "  pcompos, qtds, totas, moeds, obscompos, etiqs," + ;
                                   "  cats, cgrus, compos, dscgrp, grupos, ordems, ordcompos," + ;
                                   "  qtdcvs, qtscons, vlrcvs, cunips, pesos)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cChave)                                           + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cLinhas))                                 + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Mats))                  + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Mats))                  + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Dcompos))               + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.UniCompos))             + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Composicao.Pcompos)                 + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Composicao.Qtds)                    + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Composicao.Totas)                   + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Moeds))                 + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.ObsCompos))             + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Etiqs))                 + ", " + ;
                                   "'', '', '', '', '', " + ;
                                   FormatarNumeroSQL(loc_nOrdem)                                    + ", " + ;
                                   FormatarNumeroSQL(loc_nOrdem)                                    + ", " + ;
                                   "0, 0, 0, '', 0)"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar item composi" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL(), "LinBO.SalvarComposicao")
                            loc_lErroLoop = .T.
                        ENDIF
                    ENDIF
                    IF !loc_lErroLoop
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lErroLoop
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.SalvarComposicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarComposicaoObrigatoria - Persiste cursor_4c_CompObrig em SigPrPrc (DELETE + re-INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarComposicaoObrigatoria(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroLoop, loc_cChave
        loc_lSucesso  = .F.
        loc_lErroLoop = .F.

        IF !USED("cursor_4c_CompObrig")
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigPrPrc WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar comp. obrigat" + CHR(243) + "ria: " + CapturarErroSQL(), "LinBO.SalvarComposicaoObrigatoria")
            ELSE
                SELECT cursor_4c_CompObrig
                GO TOP
                DO WHILE !EOF("cursor_4c_CompObrig") AND !loc_lErroLoop
                    IF !DELETED()
                        loc_cChave = LEFT(fUniqueIds(), 20)
                        loc_cSQL = "INSERT INTO SigPrPrc" + ;
                                   " (cidchaves, linhas, mat1s, mat2s, cgrus, mercs)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cChave)                               + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cLinhas))                     + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_CompObrig.Mat1s))      + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_CompObrig.Mat2s))      + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_CompObrig.Cgrus))      + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_CompObrig.Mercs))      + ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar comp. obrigat" + CHR(243) + "ria: " + CapturarErroSQL(), "LinBO.SalvarComposicaoObrigatoria")
                            loc_lErroLoop = .T.
                        ENDIF
                    ENDIF
                    IF !loc_lErroLoop
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lErroLoop
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.SalvarComposicaoObrigatoria")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMateriasPrimas - Carrega cursor crMtPrima para lookups inline do grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMateriasPrimas()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cpros AS CPros, a.dpros AS DPros, a.cgrus AS CGrus" + ;
                       " FROM SigCdPro a" + ;
                       " ORDER BY a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crMtPrima")

            IF loc_nResultado >= 0
                IF USED("crMtPrima")
                    SELECT crMtPrima
                    INDEX ON CPros TAG CPros
                    INDEX ON DPros TAG DPros
                    GO TOP IN crMtPrima
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar materias primas: " + CapturarErroSQL(), "LinBO.CarregarMateriasPrimas")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.CarregarMateriasPrimas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposContaCorrente - Carrega cursor crSigCdGcr para lookup inline
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGruposContaCorrente()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGcr")

            IF loc_nResultado >= 0
                IF USED("crSigCdGcr")
                    SELECT crSigCdGcr
                    INDEX ON Codigos TAG Codigos
                    GO TOP IN crSigCdGcr
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos: " + CapturarErroSQL(), "LinBO.CarregarGruposContaCorrente")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.CarregarGruposContaCorrente")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLinhaExistente - Verifica se codigo de linha ja existe (para INCLUIR)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarLinhaExistente(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 linhas FROM SigCdLin" + ;
                       " WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaLin")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValidaLin") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ValidaLin")
                USE IN cursor_4c_ValidaLin
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.ValidarLinhaExistente")
            IF USED("cursor_4c_ValidaLin")
                USE IN cursor_4c_ValidaLin
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresAuxiliares - Fecha cursores de sub-tabelas quando form fecha
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresAuxiliares()
        IF USED("cursor_4c_Fases")
            USE IN cursor_4c_Fases
        ENDIF
        IF USED("cursor_4c_Composicao")
            USE IN cursor_4c_Composicao
        ENDIF
        IF USED("cursor_4c_CompObrig")
            USE IN cursor_4c_CompObrig
        ENDIF
        IF USED("crMtPrima")
            USE IN crMtPrima
        ENDIF
        IF USED("crSigCdGcr")
            USE IN crSigCdGcr
        ENDIF
    ENDPROC

ENDDEFINE
