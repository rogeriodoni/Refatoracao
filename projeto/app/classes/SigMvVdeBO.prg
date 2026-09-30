*==============================================================================
* SigMvVdeBO.prg
*
* Business Object para SigMvVde (Cadastro/Selecao de Vendedores)
* Form legado: SIGMVVDE.SCX - dialogo modal que resolve 11 vendedores
* (contas de SigCdCli) e devolve os codigos selecionados para o chamador
* via objeto global goVendedor (Vendedor00..Vendedor10).
*
* Tabela de referencia para os lookups: SigCdCli (IClis/RClis/Grupos)
*==============================================================================

DEFINE CLASS SigMvVdeBO AS BusinessBase

    *-- Vendedor 0 (linha "A :" do legado)
    this_cConta0  = ""
    this_cDConta0 = ""
    this_cGrupo0  = ""

    *-- Vendedor 1 (linha "1 :")
    this_cConta1  = ""
    this_cDConta1 = ""
    this_cGrupo1  = ""

    *-- Vendedor 2 (linha "2 :")
    this_cConta2  = ""
    this_cDConta2 = ""
    this_cGrupo2  = ""

    *-- Vendedor 3 (linha "3 :")
    this_cConta3  = ""
    this_cDConta3 = ""
    this_cGrupo3  = ""

    *-- Vendedor 4 (linha "4 :")
    this_cConta4  = ""
    this_cDConta4 = ""
    this_cGrupo4  = ""

    *-- Vendedor 5 (linha "5 :")
    this_cConta5  = ""
    this_cDConta5 = ""
    this_cGrupo5  = ""

    *-- Vendedor 6 (linha "6 :")
    this_cConta6  = ""
    this_cDConta6 = ""
    this_cGrupo6  = ""

    *-- Vendedor 7 (linha "7 :")
    this_cConta7  = ""
    this_cDConta7 = ""
    this_cGrupo7  = ""

    *-- Vendedor 8 (linha "8 :")
    this_cConta8  = ""
    this_cDConta8 = ""
    this_cGrupo8  = ""

    *-- Vendedor 9 (linha "9 :")
    this_cConta9  = ""
    this_cDConta9 = ""
    this_cGrupo9  = ""

    *-- Vendedor 10 (linha "10 :")
    this_cConta10  = ""
    this_cDConta10 = ""
    this_cGrupo10  = ""

    *-- .T. apos ConfirmarSelecao() persistir a escolha em go_4c_Vendedor
    this_lConfirmado = .F.

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        *-- Nao ha tabela propria de cadastro: os 11 slots de vendedor sao
        *-- resolvidos por lookup em SigCdCli (IClis = codigo da conta)
        THIS.this_cTabela = "SigCdCli"
        THIS.this_cCampoChave = "IClis"

        *-- Objeto global equivalente ao goVendedor do legado (sig.PRG),
        *-- usado pelas telas chamadoras para ler os 11 vendedores
        *-- confirmados apos este form fechar. Guarda idempotente para nao
        *-- recriar (e perder valores) se o dialogo for reaberto.
        *--
        *-- ATENCAO: a classe Empty NAO tem o METODO AddProperty - usar a
        *-- FUNCAO global ADDPROPERTY(oObj, "nome", valor). Medido no VFP9 em
        *-- 2026-09-25: go_4c_Vendedor.AddProperty(...) dispara erro 1734
        *-- "Property ADDPROPERTY is not found." e PEMSTATUS(Empty,
        *-- "AddProperty", 5) devolve .F. (Empty nao tem membro nenhum - eh
        *-- justamente o proposito da classe). AddProperty EXISTE como metodo
        *-- em Form/_SCREEN, e eh de la que vem a confusao. O erro estourava
        *-- AQUI, no Init do BO, dentro do TRY do Form -> CREATEOBJECT
        *-- devolvia .F. e o FormSigMvVde NUNCA ABRIA (menu nao fazia nada).
        IF TYPE("go_4c_Vendedor") != "O"
            PUBLIC go_4c_Vendedor
            go_4c_Vendedor = CREATEOBJECT("Empty")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor00", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor01", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor02", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor03", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor04", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor05", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor06", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor07", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor08", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor09", "")
            ADDPROPERTY(go_4c_Vendedor, "Vendedor10", "")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula os 11 slots (Conta/DConta/Grupo) a partir de
    * um cursor de pre-selecao com colunas Conta0..Conta10, DConta0..DConta10
    * e Grupo0..Grupo10 (usado quando o form e reaberto sobre uma selecao
    * anterior). Colunas ausentes no cursor sao ignoradas, sem erro.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_nI, loc_cCampoConta, loc_cCampoDConta, loc_cCampoGrupo

        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        FOR loc_nI = 0 TO 10
            loc_cCampoConta  = par_cAliasCursor + ".Conta"  + TRANSFORM(loc_nI)
            loc_cCampoDConta = par_cAliasCursor + ".DConta" + TRANSFORM(loc_nI)
            loc_cCampoGrupo  = par_cAliasCursor + ".Grupo"  + TRANSFORM(loc_nI)

            IF TYPE(loc_cCampoConta) != "U"
                STORE ALLTRIM(TratarNulo(EVALUATE(loc_cCampoConta), "")) TO ("THIS.this_cConta" + TRANSFORM(loc_nI))
            ENDIF

            IF TYPE(loc_cCampoDConta) != "U"
                STORE ALLTRIM(TratarNulo(EVALUATE(loc_cCampoDConta), "")) TO ("THIS.this_cDConta" + TRANSFORM(loc_nI))
            ENDIF

            IF TYPE(loc_cCampoGrupo) != "U"
                STORE ALLTRIM(TratarNulo(EVALUATE(loc_cCampoGrupo), "")) TO ("THIS.this_cGrupo" + TRANSFORM(loc_nI))
            ENDIF
        ENDFOR

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContaPorCodigo - Espelha o Valid legado de get_contaN (fwBuscaExt
    * com busca exata por IClis em SigCdCli). Usado pelos handlers KeyPress
    * (Enter/Tab/F4) dos 11 campos de conta do form. Cursor de saida:
    * cursor_4c_VdeBusca (IClis/RClis/Grupos), 1 linha quando encontrado.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContaPorCodigo(par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado

        loc_lResultado = .F.

        IF EMPTY(ALLTRIM(NVL(par_cConta, "")))
            THIS.this_cMensagemErro = "Informe o c" + CHR(243) + "digo da conta"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados indispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_VdeBusca")
            USE IN cursor_4c_VdeBusca
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 IClis, RClis, Grupos " + ;
                       "FROM SigCdCli " + ;
                       "WHERE IClis = " + EscaparSQL(ALLTRIM(par_cConta))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VdeBusca")

            IF loc_nResultado > 0 AND USED("cursor_4c_VdeBusca") AND RECCOUNT("cursor_4c_VdeBusca") > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o encontrada"
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar conta: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContaPorDescricao - Espelha o Valid legado de get_dcontaN
    * (fwBuscaExt com busca exata por RClis em SigCdCli). Mesmo cursor de
    * saida de BuscarContaPorCodigo.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContaPorDescricao(par_cDescricao)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado

        loc_lResultado = .F.

        IF EMPTY(ALLTRIM(NVL(par_cDescricao, "")))
            THIS.this_cMensagemErro = "Informe a descri" + CHR(231) + CHR(227) + "o da conta"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados indispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_VdeBusca")
            USE IN cursor_4c_VdeBusca
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 RClis, IClis, Grupos " + ;
                       "FROM SigCdCli " + ;
                       "WHERE RClis = " + EscaparSQL(ALLTRIM(par_cDescricao))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VdeBusca")

            IF loc_nResultado > 0 AND USED("cursor_4c_VdeBusca") AND RECCOUNT("cursor_4c_VdeBusca") > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o encontrada"
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar conta: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSelecao - Espelha "If Not Empty(get_conta0.Value)" do legado: o
    * botao Confirmar (btnSair) so age quando o vendedor "A" (slot 0) esta
    * preenchido. Vazio, o legado NAO exibe mensagem nenhuma - so nao faz
    * nada - por isso este metodo tambem devolve .F. em silencio.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSelecao()
        RETURN !EMPTY(ALLTRIM(NVL(THIS.this_cConta0, "")))
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarSelecao - Espelha o corpo do btnSair.Click do legado (menos a
    * autorizacao em si, que fica a cargo do Form/tela de autorizacao -
    * par_lAutorizado chega .T./.F. de la):
    *   - Conta0 vazio                        -> nao faz nada, devolve .F.
    *   - Conta0 preenchido e NAO autorizado   -> grava o sentinela de
    *     cancelamento (Chr(254) x10) em Vendedor00, como no legado, e
    *     devolve .F.
    *   - Conta0 preenchido e autorizado       -> copia Conta0..Conta10 para
    *     go_4c_Vendedor.Vendedor00..Vendedor10 e devolve .T.
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarSelecao(par_lAutorizado)
        LOCAL loc_nI

        IF !THIS.ValidarSelecao()
            RETURN .F.
        ENDIF

        IF TYPE("go_4c_Vendedor") != "O"
            THIS.this_cMensagemErro = "Objeto de vendedores n" + CHR(227) + "o inicializado"
            RETURN .F.
        ENDIF

        IF !par_lAutorizado
            go_4c_Vendedor.Vendedor00 = REPLICATE(CHR(254), 10)
            THIS.this_lConfirmado = .F.
            RETURN .F.
        ENDIF

        FOR loc_nI = 0 TO 10
            STORE EVALUATE("THIS.this_cConta" + TRANSFORM(loc_nI)) TO ("go_4c_Vendedor.Vendedor" + PADL(TRANSFORM(loc_nI), 2, "0"))
        ENDFOR

        THIS.this_lConfirmado = .T.
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao existe registro proprio (dialogo de selecao,
    * sem tabela): usa a conta do vendedor "A" (slot 0) como referencia caso
    * uma auditoria futura precise identificar a operacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cConta0
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - NAO sobrescritos de proposito.
    * O legado (SIGMVVDE.SCX) nao faz nenhum SQLEXEC/INSERT/UPDATE/DELETE
    * (comportamento.json: metodosComSQL = 0, totalQueries = 0) - o form eh
    * um dialogo de selecao que devolve os 11 vendedores escolhidos via
    * ConfirmarSelecao()/go_4c_Vendedor, nunca grava em SigCdCli. O
    * comportamento padrao herdado de BusinessBase (recusar Inserir/
    * Atualizar/Excluir) ja eh o correto para esta entidade.
    *--------------------------------------------------------------------------

ENDDEFINE
