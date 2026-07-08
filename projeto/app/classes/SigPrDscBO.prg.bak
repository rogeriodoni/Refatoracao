*==============================================================================
* SIGPRDSCBO.PRG - Business Object para Montagem de Descricao de Produtos
* Tabela principal: SigCdPro
* Form operacional: processa descricoes/traducoes de produtos em lote
*==============================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

    *-- Filtros de selecao
    this_cCProsI     = ""   && Codigo produto inicial (filtro intervalo)
    this_cCProsF     = ""   && Codigo produto final (filtro intervalo)
    this_cCGrus      = ""   && Codigo grupo de produto (filtro alternativo)

    *-- Propriedades do produto corrente (linha selecionada na grade)
    this_cCPros      = ""   && Codigo do produto (CPros)
    this_cDPros      = ""   && Descricao do produto (DPros)
    this_cCGrusProd  = ""   && Grupo do produto (CGrus)
    this_cCodCors    = ""   && Codigo da cor (CodCors)
    this_cPortugues  = ""   && Descricao montada em Portugues
    this_cTraduzido  = ""   && Descricao traduzida (Ingles)
    this_cDscCompras = ""   && Descricao para compras (DscCompras)
    this_cObsCompras = ""   && Observacao para compras (ObsCompras)

    *--------------------------------------------------------------------------
    * INIT - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT("SigCdPro")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCPros      = TratarNulo(CPros,      "C")
                THIS.this_cDPros      = TratarNulo(DPros,      "C")
                THIS.this_cCGrusProd  = TratarNulo(CGrus,      "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cDscCompras = TratarNulo(DscCompras, "C")
                THIS.this_cObsCompras = TratarNulo(ObsCompras, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Seleciona produtos conforme filtros para a grade
    * Popula cursor_4c_Produtos (CPros, Portugues, Traduzido, DscCompras, ObsCompras)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos()
        LOCAL loc_lResultado, loc_cSQL, loc_cFiltro, loc_cPrI, loc_cPrF, loc_cGru
        loc_lResultado = .F.

        TRY
            loc_cPrI = PADR(ALLTRIM(THIS.this_cCProsI), 14)
            loc_cPrF = PADR(ALLTRIM(THIS.this_cCProsF), 14)
            loc_cGru = PADR(ALLTRIM(THIS.this_cCGrus),  3)

            IF !EMPTY(loc_cGru)
                loc_cFiltro = "CGrus = '" + loc_cGru + "'"
            ELSE
                loc_cFiltro = "CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "'"
            ENDIF

            loc_cSQL = "SELECT CPros, '' AS Portugues, '' AS Traduzido, " + ;
                       "ISNULL(DscCompras,'') AS DscCompras, " + ;
                       "ISNULL(ObsCompras,'') AS ObsCompras " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cFiltro + " " + ;
                       "ORDER BY CPros"

            IF USED("cursor_4c_ProdutosTemp")
                USE IN cursor_4c_ProdutosTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTemp") < 1
                THIS.this_cMensagemErro = "Falha ao buscar produtos"
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_Produtos")
                TABLEREVERT(.T., "cursor_4c_Produtos")
                USE IN cursor_4c_Produtos
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos ;
                (CPros C(14) NULL, Portugues C(254) NULL, Traduzido C(254) NULL, ;
                 DscCompras M(4) NULL, ObsCompras M(4) NULL)
            SET NULL OFF

            IF RECCOUNT("cursor_4c_ProdutosTemp") > 0
                SELECT cursor_4c_Produtos
                APPEND FROM DBF("cursor_4c_ProdutosTemp")
            ENDIF

            IF USED("cursor_4c_ProdutosTemp")
                USE IN cursor_4c_ProdutosTemp
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDescricoes - Monta descricoes em Portugues e traduz para Ingles
    * Usa crSigCdDic (dicionario) e SigCdGrp/SigCdCor para montar descricao
    * Popula colunas Portugues/Traduzido de cursor_4c_Produtos
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDescricoes()
        LOCAL loc_lResultado, loc_cSQL, loc_cPro, loc_cDes, loc_cIng
        LOCAL loc_cPrI, loc_cPrF, loc_cGru, loc_cFiltro
        LOCAL loc_cDGrus, loc_cDescs, loc_nMontaGrDs
        loc_lResultado = .F.

        TRY
            loc_cPrI = PADR(ALLTRIM(THIS.this_cCProsI), 14)
            loc_cPrF = PADR(ALLTRIM(THIS.this_cCProsF), 14)
            loc_cGru = PADR(ALLTRIM(THIS.this_cCGrus),  3)

            IF !EMPTY(loc_cGru)
                loc_cFiltro = "a.CGrus = '" + loc_cGru + "'"
            ELSE
                loc_cFiltro = "a.CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "'"
            ENDIF

            loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, " + ;
                       "b.DGrus, b.Mercs, b.MontaGrDs, c.Descs " + ;
                       "FROM SigCdPro a " + ;
                       "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                       "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                       "WHERE " + loc_cFiltro + " " + ;
                       "ORDER BY a.CPros"

            IF USED("cursor_4c_ProdInfoTemp")
                USE IN cursor_4c_ProdInfoTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfoTemp") < 1
                THIS.this_cMensagemErro = "Falha ao buscar informa" + CHR(231) + CHR(245) + "es dos produtos"
                loc_lResultado = .F.
            ENDIF

            IF !USED("cursor_4c_Produtos")
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado"
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Produtos
            ZAP

            SELECT cursor_4c_ProdInfoTemp
            GO TOP
            DO WHILE !EOF("cursor_4c_ProdInfoTemp")
                loc_cPro    = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.CPros,   ""))
                loc_cDGrus  = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.DGrus,   ""))
                loc_cDescs  = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.Descs,   ""))
                loc_nMontaGrDs = NVL(cursor_4c_ProdInfoTemp.MontaGrDs, 0)

                IF !EMPTY(loc_cPro)
                    *-- Monta descricao base: Grupo + Cor
                    loc_cDes = ALLTRIM(loc_cDGrus + " " + loc_cDescs)

                    IF !EMPTY(loc_cDes)
                        *-- Aplica dicionario de traducao
                        loc_cIng = loc_cDes
                        IF USED("cursor_4c_Dicionario")
                            SELECT cursor_4c_Dicionario
                            GO TOP
                            DO WHILE !EOF("cursor_4c_Dicionario")
                                loc_cIng = STRTRAN(loc_cIng, ;
                                    ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                    ALLTRIM(cursor_4c_Dicionario.Traducao))
                                SKIP IN cursor_4c_Dicionario
                            ENDDO
                        ENDIF

                        *-- Limpa caracteres especiais para SQL
                        loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                        loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                        SELECT cursor_4c_Produtos
                        INSERT INTO cursor_4c_Produtos ;
                            (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                            VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)
                    ENDIF
                ENDIF

                SKIP IN cursor_4c_ProdInfoTemp
            ENDDO

            IF USED("cursor_4c_ProdInfoTemp")
                USE IN cursor_4c_ProdInfoTemp
            ENDIF

            SELECT cursor_4c_Produtos
            GO TOP

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDicionario - Carrega SigCdDic (Ingles) em cursor_4c_Dicionario
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDicionario()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Expressao, Traducao " + ;
                       "FROM SigCdDic " + ;
                       "WHERE Idioma = 'INGLES    ' " + ;
                       "ORDER BY LEN(Expressao) DESC, Expressao"

            IF USED("cursor_4c_Dicionario")
                USE IN cursor_4c_Dicionario
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario") < 1
                THIS.this_cMensagemErro = "Falha ao carregar dicion" + CHR(225) + "rio"
                loc_lResultado = .F.
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDescricoes - Atualiza SigCdPro e limpa SigPrPrt em lote
    * Percorre cursor_4c_Produtos e faz UPDATE em cada produto
    *--------------------------------------------------------------------------
    PROCEDURE GravarDescricoes(par_oProgressBar)
        LOCAL loc_lResultado, loc_lOks, loc_cSQL, loc_cPro
        LOCAL loc_cPortugues, loc_cTraduzido, loc_cDscCompras, loc_cObsCompras
        loc_lResultado = .F.
        loc_lOks = .T.

        TRY
            IF !USED("cursor_4c_Produtos")
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado"
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Produtos
            GO TOP

            DO WHILE !EOF("cursor_4c_Produtos") AND loc_lOks
                loc_cPro         = ALLTRIM(NVL(cursor_4c_Produtos.CPros,       ""))
                loc_cPortugues   = ALLTRIM(NVL(cursor_4c_Produtos.Portugues,   ""))
                loc_cTraduzido   = ALLTRIM(NVL(cursor_4c_Produtos.Traduzido,   ""))
                loc_cDscCompras  = ALLTRIM(NVL(cursor_4c_Produtos.DscCompras,  ""))
                loc_cObsCompras  = ALLTRIM(NVL(cursor_4c_Produtos.ObsCompras,  ""))

                IF VARTYPE(par_oProgressBar) = "O"
                    par_oProgressBar.SubTitulo.Caption = "Produto : " + loc_cPro
                    par_oProgressBar.Update(.T.)
                ENDIF

                *-- UPDATE SigCdPro
                loc_cSQL = "UPDATE SigCdPro " + ;
                           "SET DscCompras = " + EscaparSQL(loc_cDscCompras) + ", " + ;
                           "ObsCompras = " + EscaparSQL(loc_cObsCompras) + ", " + ;
                           "DPros = '" + PADR(loc_cPortugues, 40) + "' " + ;
                           "WHERE CPros = " + EscaparSQL(loc_cPro)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar produto " + loc_cPro
                    loc_lOks = .F.
                ENDIF

                IF loc_lOks
                    *-- DELETE SigPrPrt
                    loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                        THIS.this_cMensagemErro = "Falha ao limpar SigPrPrt para " + loc_cPro
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF loc_lOks
                    SKIP IN cursor_4c_Produtos
                ELSE
                    EXIT
                ENDIF
            ENDDO

            loc_lResultado = loc_lOks
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (CPros)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCPros)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - NAO aplicavel: form operacional nao cria produtos novos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza descricoes de um produto individual em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCPros)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdPro " + ;
                       "SET DscCompras = " + EscaparSQL(THIS.this_cDscCompras) + ", " + ;
                       "ObsCompras = " + EscaparSQL(THIS.this_cObsCompras) + ", " + ;
                       "DPros = '" + PADR(ALLTRIM(THIS.this_cPortugues), 40) + "' " + ;
                       "WHERE CPros = '" + ALLTRIM(THIS.this_cCPros) + "'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                THIS.this_cMensagemErro = "Falha ao atualizar produto " + ALLTRIM(THIS.this_cCPros)
                loc_lResultado = .F.
            ENDIF

            THIS.RegistrarAuditoria("A")

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cCProsI     = ""
        THIS.this_cCProsF     = ""
        THIS.this_cCGrus      = ""
        THIS.this_cCPros      = ""
        THIS.this_cDPros      = ""
        THIS.this_cCGrusProd  = ""
        THIS.this_cCodCors    = ""
        THIS.this_cPortugues  = ""
        THIS.this_cTraduzido  = ""
        THIS.this_cDscCompras = ""
        THIS.this_cObsCompras = ""
        THIS.this_cMensagemErro = ""
    ENDPROC

ENDDEFINE
