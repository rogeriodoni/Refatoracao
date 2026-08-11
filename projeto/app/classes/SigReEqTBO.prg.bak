*==============================================================================
* SIGREEQTBO.PRG
* Business Object para Estoque Retroativo (SigReEqT)
* Herda de RelatorioBase
*
* IMPORTANTE: Este relatorio e um formulario filho que recebe cursores
* pre-carregados do form pai via DataSession. Nao executa SQL proprio.
* Cursors de entrada: csTempoGr (sintetico/grupos) e csTempoCp (analitico/produtos)
*==============================================================================

DEFINE CLASS SigReEqTBO AS RelatorioBase

    *-- Opcao de visualizacao: 1=Analitico (por produto), 2=Sintetico (por grupo)
    *-- Valor padrao 2 = Sintetico (igual ao original: Opt_Key.Value = 2)
    this_nOpcao             = 2

    *-- Nomes dos cursors de dados (preenchidos pelo form pai via Set DataSession)
    this_cCursorGrupos      = "cursor_4c_TempoGr"
    this_cCursorProdutos    = "cursor_4c_TempoCp"

    *-- Nomes dos arquivos FRX (sem extensao e sem caminho)
    *-- SigReEq1 = Analitico (csTempoCp, com ordem Imprimir)
    *-- SigReEq2 = Sintetico (csTempoGr)
    this_cFrxAnalitico      = "SigReEq1"
    this_cFrxSintetico      = "SigReEq2"

    *-- Titulo exibido no cabecalho do form
    this_cTitulo            = "Estoque Retroativo"

    *-- Mensagem de erro da ultima operacao
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO de Estoque Retroativo
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela      = ""
            THIS.this_cCampoChave  = ""
            THIS.this_cTitulo      = "Estoque Retroativo"
            THIS.this_nOpcao       = 2

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Valida cursors fornecidos pelo form pai via DataSession
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorGrupos)
                THIS.this_cMensagemErro = "Cursor de grupos n" + CHR(227) + "o encontrado: " + THIS.this_cCursorGrupos
                loc_lSucesso = .F.
            ENDIF
            IF !USED(THIS.this_cCursorProdutos)
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado: " + THIS.this_cCursorProdutos
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOpcao - Define opcao de visualizacao/impressao
    * par_nOpcao: 1=Analitico (por produto), 2=Sintetico (por grupo)
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOpcao(par_nOpcao)
        THIS.this_nOpcao = par_nOpcao
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Imprime relatorio com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER PROMPT NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER PROMPT NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) PREVIEW NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterExpressaoCor - Retorna expressao DynamicForeColor para grid de grupos
    * Quebra='1' exibe em azul; Tipos='6' exibe em vermelho; demais em preto
    *--------------------------------------------------------------------------
    FUNCTION ObterExpressaoCor()
        RETURN "IIF(Quebra='1',RGB(0,0,255),IIF(Tipos='6',RGB(255,0,0),RGB(0,0,0)))"
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarFiltroProdutos - Filtra cursor de produtos pelo grupo selecionado
    * Equivalente ao Page2.Activate do original (SET KEY TO Grupos+Contas+Linhas)
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarFiltroProdutos()
        LOCAL loc_lSucesso, loc_cGrupos, loc_cContas, loc_cLinhas
        loc_lSucesso = .F.
        TRY
            SELECT (THIS.this_cCursorGrupos)
            loc_cGrupos = Grupos
            loc_cContas = Contas
            loc_cLinhas = Linhas

            SELECT (THIS.this_cCursorProdutos)
            SET ORDER TO Visualizar
            SET KEY TO loc_cGrupos + loc_cContas + loc_cLinhas
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparFiltroProdutos - Remove filtro SET KEY TO do cursor de produtos
    * Equivalente ao Page2.Deactivate do original
    *--------------------------------------------------------------------------
    PROCEDURE LimparFiltroProdutos()
        LOCAL loc_oErro
        TRY
            SELECT (THIS.this_cCursorProdutos)
            SET KEY TO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Configura cursor de dados para o relatorio
    * par_cAliasCursor: alias do cursor preenchido pelo form pai
    * par_cTipo: "ANALITICO" (produtos/csTempoCp) ou "SINTETICO" (grupos/csTempoGr)
    *
    * Equivalente ao Init original que recebia poForm e setava DataSession.
    * Permite ao form pai injetar dinamicamente os cursors a usar.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor, par_cTipo)
        LOCAL loc_lSucesso, loc_cTipo
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor)
                THIS.this_cMensagemErro = "Alias do cursor n" + CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o existe: " + par_cAliasCursor
                loc_lSucesso = .F.
            ENDIF

            loc_cTipo = UPPER(ALLTRIM(NVL(par_cTipo, "SINTETICO")))
            IF loc_cTipo == "ANALITICO"
                THIS.this_cCursorProdutos = par_cAliasCursor
                THIS.this_nOpcao = 1
            ELSE
                THIS.this_cCursorGrupos = par_cAliasCursor
                THIS.this_nOpcao = 2
            ENDIF

            SELECT (par_cAliasCursor)
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada por BO de relat" + CHR(243) + "rio
    *
    * Relat" + CHR(243) + "rios apenas LEEM dados de cursors preenchidos pelo form pai.
    * Inser" + CHR(231) + CHR(245) + "es em tabelas de movimento s" + CHR(227) + "o feitas em BOs CRUD espec" + CHR(237) + "ficos.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios"
        MsgAviso(THIS.this_cMensagemErro)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada por BO de relat" + CHR(243) + "rio
    *
    * Relat" + CHR(243) + "rios apenas LEEM dados de cursors preenchidos pelo form pai.
    * Atualiza" + CHR(231) + CHR(245) + "es de registros s" + CHR(227) + "o feitas em BOs CRUD espec" + CHR(237) + "ficos.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios"
        MsgAviso(THIS.this_cMensagemErro)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do cursor ativo para fins de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        TRY
            IF USED(THIS.this_cCursorGrupos)
                SELECT (THIS.this_cCursorGrupos)
                IF !EOF() AND TYPE(THIS.this_cCursorGrupos + ".Grupos") == "C"
                    loc_cChave = ALLTRIM(EVALUATE(THIS.this_cCursorGrupos + ".Grupos"))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra emiss" + CHR(227) + "o de relat" + CHR(243) + "rio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cTipoRelatorio, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .F.
            ENDIF

            loc_cTipoRelatorio = IIF(THIS.this_nOpcao = 1, "Analitico", "Sintetico")
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + ;
                EscaparSQL("SigReEqT") + ", " + ;
                EscaparSQL(LEFT(NVL(par_cOperacao, "RELATORIO"), 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.ObterChavePrimaria() + "|" + loc_cTipoRelatorio, 100)) + ", " + ;
                EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                "GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
