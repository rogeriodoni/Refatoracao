*====================================================================
* SIGPRTRFBO.prg
*
* Business Object para Relacao de Produtos (Transferencia)
* Tabelas: SigCdPro (validacao/lookup de produto), SigCdPac (parametro ClockEcfs)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRTRFBO AS BusinessBase

    *-- Propriedades da entidade (produto sendo incluido na relacao)
    this_cCodigoProduto    = ""    && SigCdPro.cpros char(14) - PK
    this_cDescricaoProduto = ""    && SigCdPro.dpros char(40)

    *-- Propriedade de parametro de sistema (usada no aguarde de confirmacao)
    this_nTempoEspera = 0          && SigCdPac.ClockEcfs numeric

    *-- Propriedade de resultado (lista de codigos de produto separados por virgula)
    this_cListaProdutos = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "cpros"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGPRTRFBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * SIGPRTRF eh um dialogo de selecao (sem INSERT/UPDATE/DELETE no
    * legado): o Click do botao "Ok" so conta/monta a lista de produtos
    * informados na grade (THIS.MontarListaProdutos) e fecha o form com
    * ThisForm.Retorno = 'Ok'. Inserir()/Atualizar()/ExecutarExclusao()
    * NAO sao sobrescritos aqui - o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto, porque este BO
    * nao grava em tabela nenhuma; quem persiste a transferencia eh o
    * processo que consome THIS.this_cListaProdutos apos o form fechar.
    *====================================================================

    *====================================================================
    * ValidarProduto - Valida codigo de produto contra SigCdPro
    *
    * Equivalente ao legado (Grade.Column1.Text1.Valid):
    *   CreateObject('fwBuscaExt', poDataMgr.pnIdConn, 'SigCdPro',
    *                 'CrProds', 'cpros', This.Value, 'Produtos', 1000)
    *
    * Parametros: par_cCodigo - codigo digitado (coluna SigCdPro.cpros)
    * Retorno: .T. se encontrou o produto (preenche this_cCodigoProduto/
    *          this_cDescricaoProduto), .F. caso contrario
    *====================================================================
    FUNCTION ValidarProduto(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(ALLTRIM(par_cCodigo))
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ValidaProduto")
                USE IN cursor_4c_ValidaProduto
            ENDIF

            loc_cSQL = "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaProduto")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaProduto") > 0
                SELECT cursor_4c_ValidaProduto
                GO TOP
                THIS.this_cCodigoProduto    = ALLTRIM(TratarNulo(cpros, ""))
                THIS.this_cDescricaoProduto = ALLTRIM(TratarNulo(dpros, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cCodigoProduto    = ""
                THIS.this_cDescricaoProduto = ""
                THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado"
            ENDIF

            IF USED("cursor_4c_ValidaProduto")
                USE IN cursor_4c_ValidaProduto
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SIGPRTRFBO.ValidarProduto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarParametroTempoEspera - Le SigCdPac.ClockEcfs
    *
    * Equivalente ao legado (PROCEDURE Init do form):
    *   lcSql = [Select ClockEcfs From SigCdPac]
    *   ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac')
    *
    * Tempo de espera (segundos), em numeric(4,0), usado na animacao de
    * confirmacao do botao "Ok".
    * Retorno: .T. se encontrou o parametro (preenche this_nTempoEspera)
    *====================================================================
    FUNCTION CarregarParametroTempoEspera()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_nTempoEspera = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ParamTempo")
                USE IN cursor_4c_ParamTempo
            ENDIF

            loc_cSQL = "SELECT clockecfs FROM SigCdPac"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamTempo")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ParamTempo") > 0
                SELECT cursor_4c_ParamTempo
                GO TOP
                THIS.this_nTempoEspera = NVL(clockecfs, 0)
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_ParamTempo")
                USE IN cursor_4c_ParamTempo
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SIGPRTRFBO.CarregarParametroTempoEspera")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * MontarListaProdutos - Conta os produtos informados na grade e monta
    * a lista final separada por virgula (this_cListaProdutos)
    *
    * Equivalente ao legado (PROCEDURE Click do botao "Ok"):
    *   Select CrProduto
    *   Count to x for Not Empty(Cpros)
    *   If x=0
    *       MessageBox('Nenhum Produto Informado!!!',0+16,'')
    *       Return .f.
    *   Endif
    *
    * Parametros: par_cCursorProdutos - alias do cursor da grade (coluna
    *             cpros, igual ao CrProduto do legado)
    * Retorno: numero de produtos validos encontrados (0 = nenhum)
    *====================================================================
    FUNCTION MontarListaProdutos(par_cCursorProdutos)
        LOCAL loc_nQtde, loc_cLista, loc_cAliasAnterior, loc_nRecnoAnterior

        loc_nQtde  = 0
        loc_cLista = ""
        THIS.this_cListaProdutos = ""

        IF VARTYPE(par_cCursorProdutos) != "C" OR !USED(par_cCursorProdutos)
            RETURN 0
        ENDIF

        loc_cAliasAnterior = ALIAS()

        SELECT (par_cCursorProdutos)

        *-- COUNT e SCAN varrem o cursor INTEIRO e deixam o ponteiro em EOF.
        *-- Guardar a LINHA CORRENTE (nao basta guardar o ALIAS): o chamador
        *-- eh a grade, e devolve-la posicionada em EOF faz a transferencia
        *-- da linha corrente (FormParaBO/BOParaForm do form) deixar de achar
        *-- registro - nada eh gravado, sem erro e sem aviso.
        loc_nRecnoAnterior = RECNO(par_cCursorProdutos)

        COUNT TO loc_nQtde FOR !EMPTY(cpros)

        IF loc_nQtde > 0
            SCAN FOR !EMPTY(cpros)
                IF !EMPTY(loc_cLista)
                    loc_cLista = loc_cLista + ","
                ENDIF
                loc_cLista = loc_cLista + ALLTRIM(cpros)
            ENDSCAN
        ENDIF

        THIS.this_cListaProdutos = loc_cLista

        *-- Repoe a linha corrente. GO so eh valido dentro do intervalo de
        *-- registros: RECNO() devolve RECCOUNT()+1 quando o ponteiro ja
        *-- estava em EOF ao entrar no metodo.
        IF BETWEEN(loc_nRecnoAnterior, 1, RECCOUNT(par_cCursorProdutos))
            GO loc_nRecnoAnterior IN (par_cCursorProdutos)
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_nQtde
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega this_cCodigoProduto/this_cDescricaoProduto
    * a partir do registro corrente do cursor informado (usado apos o
    * lookup de produto preencher cpros/dpros na linha da grade)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE("cpros") != "U"
            THIS.this_cCodigoProduto = ALLTRIM(TratarNulo(cpros, ""))
        ENDIF

        IF TYPE("dpros") != "U"
            THIS.this_cDescricaoProduto = ALLTRIM(TratarNulo(dpros, ""))
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave do produto corrente (usada so se algum
    * dia este BO vier a registrar auditoria de uma linha especifica)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigoProduto
    ENDPROC

ENDDEFINE
