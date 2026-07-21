*==============================================================================
* SIGPRCCRBO.PRG
* Business Object - Relatorio: Impressao de Produtos com Precos Alterados
*
* Herda de RelatorioBase
* Opera sobre cursor CrProdutos (criado pelos forms pai: SigPrCcc, SigPrCcp, etc.)
* Filtra lMarca = 1 e gera CsRelatorio para o FRX SigPrCcr
*==============================================================================

DEFINE CLASS SIGPRCCRBO AS RelatorioBase

    *-- Relatorio e cursor de saida (DEVE bater com nomes esperados pelo FRX legado)
    this_cRelatorio     = "SigPrCcr"
    this_cCursorDados   = "CsRelatorio"
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta CsCabecalho e CsRelatorio a partir de CrProdutos
    * CrProdutos deve existir em memoria (criado pelo form pai com lMarca marcado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpresa
        LOCAL loc_cTitulo, loc_cSubTit
        loc_lSucesso = .F.

        TRY
            *-- Verifica se cursor CrProdutos existe
            IF !USED("CrProdutos")
                THIS.this_cMensagemErro = "Cursor CrProdutos n" + CHR(227) + "o encontrado. " + ;
                    "Execute a marca" + CHR(231) + CHR(227) + "o de produtos antes de imprimir."
                loc_lSucesso = .F.
            ENDIF

            *-- Busca razao social da empresa
            loc_cEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    loc_cEmpresa = ALLTRIM(NVL(cursor_4c_Emp.Razas, ""))
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta cursor de cabecalho (alias legado: CsCabecalho)
            loc_cTitulo = "Rela" + CHR(231) + CHR(227) + "o de Produtos com Pre" + CHR(231) + "o Alterado "
            loc_cSubTit = "Em " + DTOC(DATE())

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (cb_empresa C(80), titulo C(80), SubTitulo C(80))
            INSERT INTO CsCabecalho (cb_empresa, titulo, SubTitulo) ;
                VALUES (loc_cEmpresa, loc_cTitulo, loc_cSubTit)

            *-- Monta cursor de relatorio filtrando produtos marcados (alias legado: CsRelatorio)
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            SELECT * FROM CrProdutos WHERE lMarca = 1 INTO CURSOR CsRelatorio ORDER BY Cpros
            SELECT CsRelatorio
            GO TOP

            IF RECCOUNT("CsRelatorio") = 0
                THIS.this_cMensagemErro = "Nenhum produto marcado para impress" + CHR(227) + "o."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao preparar dados: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e sinaliza sucesso para o form executar REPORT FORM
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Alias de Imprimir() para compatibilidade com Pattern #122
    * (handlers de botao REPORT chamam Atualizar() antes de ExecutarReportForm)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Imprimir()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Emp")
            USE IN cursor_4c_Emp
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
